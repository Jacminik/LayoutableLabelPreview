import UIKit

public class Preview: UIView {
    
    var texts: [String] { return [
        "洋酒といえば、誰でも最初に思い浮かべるのがウイスキー。いわば洋酒のシンボル的な存在なのだが、英語表記が［一般に〔米〕ではWhiskey,〔英〕では Whisky.］であることはあまり知られていない。",
        "米英両国では、このスペルの差で自国産と輸入品を区別しているという。わが和製ウイスキーの“Whisky”という英国式表示は、手本にしたスコッチのフォルムに倣ったものであり、それ以上の意味はないようだ。",
        "カナ表記にしても、ごくまれに〈ウヰスキー〉という書き方を見かけるが、これとて差別化を意図したものではなく単にカナづかいの時代性にすぎない。"] }
    public var labels: [LayoutableLabel]? { return subviews.flatMap({ $0 as? LayoutableLabel }) }
    private var didLayout = false
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        self.backgroundColor = .blackColor()
        setupLabels()
        setNeedsUpdateConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLabels() {
        for text in texts {
            let label = LayoutableLabel(frame: CGRect.zero)
            label.numberOfLines = 0
            label.backgroundColor = .clearColor()
            label.textColor = .whiteColor()
            label.font = UIFont.systemFontOfSize(24)
            label.text = text
            addSubview(label)
            
            label.layer.borderColor = UIColor.darkGrayColor().CGColor
            label.layer.borderWidth = 1
        }
    }
    
    override public func updateConstraints() {
        super.updateConstraints()
        guard let labels = labels where labels.count == texts.count && !didLayout else {
            return
        }
        self.didLayout = true
        
        var constrains = [NSLayoutConstraint]()
        for (index, label) in labels.enumerate() {
            label.translatesAutoresizingMaskIntoConstraints = false
            if index == 0 {
                constrains.append(label.constraint(forTopSpace: 20, container: self))
            } else {
                constrains.append(label.constraint(forSpace: 20, attribute: .Top, toItem: labels[index - 1], toAttribute: .Bottom))
            }
            constrains.appendContentsOf([
                label.constraint(forLeadingSpace: 16, container: self),
                label.constraint(forTrailingSpace: -16, container: self),
                ])
        }
        addConstraints(constrains)
    }
}
