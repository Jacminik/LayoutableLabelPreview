//
//  LayoutableLabel.swift
//
//  Created by Masahiro Katsumata on 2016/04/07.
//  Copyright © 2016年 +Beans. All rights reserved.
//

import UIKit


/// ヒラギノ用フォント情報
public struct FontInfo {
    
    public enum Weight {
        case Normal, Bold
        private var suffixNo: String {
            switch self {
            case .Normal: return "3"
            case .Bold: return "6"
            }
        }
    }
    
    private(set) var name: String
    private(set) var size: CGFloat
    public var font: UIFont! { return UIFont(name: name, size: size) }
    
    public init(size: CGFloat, weight: Weight = .Normal) {
        self.name = "HiraKakuProN-W" + weight.suffixNo
        self.size = size
    }
}

public extension UIFont {
    
    public convenience init(info: FontInfo) {
        self.init(name: info.name, size: info.size)!
    }
}

public extension UILabel {
    
    public func fontInfo(weight: FontInfo.Weight = .Normal) -> FontInfo {
        return FontInfo(size: font.pointSize, weight: weight)
    }
}

public struct TextLayout {
    
    private(set) var font: UIFont
    private(set) var lineHeight: CGFloat
    private(set) var letterSpacing: CGFloat
    private(set) var sideInset: CGFloat
    private(set) var topInset: CGFloat
    private(set) var indent: CGFloat
    private(set) var topOffset: CGFloat
    public var edgeInsets: UIEdgeInsets { return UIEdgeInsets(top: topInset + topOffset, left: indent + sideInset, bottom: 0, right: sideInset) }
    
    /// イニシャライザ
    public init(info: FontInfo, lineSpacing: CGFloat = 0, letterSpacing: CGFloat = 0, sideInset: CGFloat = 0, topInset: CGFloat = 0, indent: CGFloat = 0) {
        self.font = info.font
        self.lineHeight = (font.pointSize + lineSpacing).roundHalf
        self.letterSpacing = letterSpacing
        self.sideInset = sideInset
        self.topInset = topInset
        self.indent = indent
        self.topOffset = font.pointSize - lineHeight
    }
    
    public func drawingWidth(contentWidth: CGFloat) -> CGFloat {
        return contentWidth - (sideInset * 2.0) - indent
    }
}


/// コード上で簡易的にレイアウトを実装できるラベル。
public class LayoutableLabel: UILabel {
    
    public var layout: TextLayout? { didSet { didSetLayout() } }
    private(set) var textAttributes = [String: AnyObject]()
    override public var text: String? { didSet { updateAttributedText() } }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if numberOfLines != 1 && lineBreakMode.rawValue < NSLineBreakMode.ByTruncatingHead.rawValue {
            // 複数行の場合のみ禁則処理をかける
            self.lineBreakMode = .ByWordWrapping
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        guard let edgeInsets = layout?.edgeInsets else {
            return super.textRectForBounds(bounds, limitedToNumberOfLines: numberOfLines)
        }
        let rect = super.textRectForBounds(edgeInsets.apply(bounds), limitedToNumberOfLines: numberOfLines)
        return edgeInsets.inverse.apply(rect)
    }
    
    override public func drawTextInRect(rect: CGRect) {
        guard let edgeInsets = layout?.edgeInsets else {
            return super.drawTextInRect(rect)
        }
        super.drawTextInRect(edgeInsets.apply(rect))
    }
    
    override public func actualHeightForWidth(width: CGFloat) -> CGFloat {
        return super.actualHeightForWidth(layout?.drawingWidth(width) ?? width)
    }
    
    public func setLayout(fontSize size: CGFloat? = nil, weight: FontInfo.Weight = .Normal, lineSpacing: CGFloat = 0, letterSpacing: CGFloat = 0, sideInset: CGFloat = 0, topInset: CGFloat = 0, indent: CGFloat = 0) {
        let fontInfo: FontInfo = {
            guard let size = size else {
                return self.fontInfo(weight)
            }
            return FontInfo(size: size, weight: weight)
        }()
        self.layout = TextLayout(info: fontInfo, lineSpacing: lineSpacing, letterSpacing: letterSpacing, sideInset: sideInset, topInset: topInset, indent: indent)
    }
    
    private func updateAttributedText() {
        guard let text = text where !text.isEmpty && !textAttributes.isEmpty else {
//            self.attributedText = nil
            return
        }
        self.attributedText = NSAttributedString(string: text, attributes: textAttributes)
    }
    
    private func didSetLayout() {
        self.font = layout?.font
        updateTextAttributes()
        updateAttributedText()
    }
    
    private func updateTextAttributes() {
        guard let layout = layout else {
            self.textAttributes = [String: AnyObject]()
            return
        }
        textAttributes[NSParagraphStyleAttributeName] = {
            let style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as? NSMutableParagraphStyle
            style?.lineBreakMode = self.lineBreakMode
            style?.alignment = self.textAlignment
            style?.minimumLineHeight = layout.lineHeight
            style?.maximumLineHeight = layout.lineHeight
            return style
            }()
        textAttributes[NSKernAttributeName] = layout.letterSpacing
        textAttributes[NSFontAttributeName] = font
    }
}
