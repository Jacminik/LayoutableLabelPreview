//
//  UILabel+Expanded.swift
//
//  Created by Masahiro Katsumata on 2016/04/07.
//  Copyright © 2016年 +Beans. All rights reserved.
//

import UIKit

public extension UILabel {
    
    /// numberOfLines:0の場合の高さを返却。
    func actualHeightForWidth(width: CGFloat) -> CGFloat {
        let tempLimit = numberOfLines
        self.numberOfLines = 0
        let result = sizeThatFits(CGSize(width, CGFloat(FLT_MAX))).height + 1
        self.numberOfLines = tempLimit
        return result
    }
    
    var isEmptyText: Bool {
        return text == nil || text!.isEmpty
    }
}


extension String {
    
//    func actualHeightForWidth(width: CGFloat, font: UIFont) -> CGFloat {
//        if !isEmpty {
//            
//            let style = NSMutableParagraphStyle()
//            style.lineBreakMode = .ByWordWrapping
//            
//            let attr = [
//                NSFontAttributeName : font,
//                NSParagraphStyleAttributeName : style]
//            
//            let attrString = NSAttributedString(string: self, attributes: attr),
//            framesetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedStringRef),
//            tempSize = CGSizeMake(width, CGFloat(FLT_MAX)),
//            result = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, attrString.length), nil, tempSize, nil)
//            return ceil(result.height)
//        }
//        return 0.0
//    }
    
//    func numberOfLinesForWidth(width: CGFloat, font: UIFont) -> Int {
//        if !isEmpty {
//            
//            let style = NSMutableParagraphStyle()
//            style.lineBreakMode = .ByWordWrapping
//            style.minimumLineHeight = font.lineHeight
//            style.maximumLineHeight = font.lineHeight
//            
//            let attr = [
//                NSFontAttributeName : font,
//                NSParagraphStyleAttributeName : style]
//            
//            let attrString = NSAttributedString(string: self, attributes: attr),
//            framesetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedStringRef),
//            tempSize = CGSizeMake(width, CGFloat(FLT_MAX)),
//            result = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, attrString.length), nil, tempSize, nil)
//            return Int(ceil(result.height) / font.lineHeight)
//        }
//        return 0
//    }
}
