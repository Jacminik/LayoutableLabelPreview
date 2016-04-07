//
//  AutoLayoutExtensions.swift
//
//  Created by Masahiro Katsumata on 2016/04/07.
//  Copyright © 2016年 +Beans. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    
    convenience init(item: AnyObject, attribute: NSLayoutAttribute, relatedBy: NSLayoutRelation = .Equal, constant c: CGFloat) {
        self.init(item: item, attribute: attribute, relatedBy: relatedBy, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: c)
    }
    
    func isFirstItem(item: NSObject) -> Bool {
        guard let target = firstItem as? NSObject else {
            return false
        }
        return target == item
    }
    
    func isSecondItem(item: NSObject) -> Bool {
        guard let target = secondItem as? NSObject else {
            return false
        }
        return target == item
    }
}

public extension UIView {
    
    func constraint(container: UIView, attribute: NSLayoutAttribute, constant: CGFloat, relatedBy relation: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relation, toItem: container, attribute: attribute, multiplier: 1, constant: constant)
    }
    
    // MARK: Make NSLayoutConstraint
    
    func constraint(forWidth width: CGFloat, relatedBy relation: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .Width, relatedBy: relation, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: width)
    }
    
    func constraint(forHeight height: CGFloat, relatedBy relation: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .Height, relatedBy: relation, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: height)
    }
    
    func constraint(forAspect aspect: CGSize) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: aspect.width / aspect.height, constant: 0)
    }
    
    func constraint(forTopSpace top: CGFloat, container: UIView, relatedBy relation: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        return constraint(container, attribute: .Top, constant: top, relatedBy: relation)
    }
    
    func constraint(forBottomSpace bottom: CGFloat, container: UIView, relatedBy relation: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        return constraint(container, attribute: .Bottom, constant: bottom, relatedBy: relation)
    }
    
    func constraint(forLeadingSpace leading: CGFloat, container: UIView, relatedBy relation: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        return constraint(container, attribute: .Leading, constant: leading, relatedBy: relation)
    }
    
    func constraint(forTrailingSpace trailing: CGFloat, container: UIView, relatedBy relation: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        return constraint(container, attribute: .Trailing, constant: trailing, relatedBy: relation)
    }
    
    func constraint(forCenterY centerY: CGFloat, container: UIView, relatedBy relation: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        return constraint(container, attribute: .CenterY, constant: centerY, relatedBy: relation)
    }
    
    func constraint(forCenterX centerX: CGFloat, container: UIView, relatedBy relation: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        return constraint(container, attribute: .CenterX, constant: centerX, relatedBy: relation)
    }
    
    func constraint(forSpace space: CGFloat, attribute: NSLayoutAttribute, toItem: UIView, toAttribute: NSLayoutAttribute, relatedBy relation: NSLayoutRelation = .Equal) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: toItem, attribute: toAttribute, multiplier: 1, constant: space)
    }
    
    
    // MARK: Add Constraints
    
    func addConstraint(forWidth width: CGFloat) {
        addConstraint(constraint(forWidth: width))
    }
    
    func addConstraint(forHeight height: CGFloat) {
        addConstraint(constraint(forHeight: height))
    }
    
    func addConstraints(forSize size: CGSize) {
        addConstraints([constraint(forWidth: size.width), constraint(forHeight: size.height)])
    }
    
    func addConstraint(forAspect aspect: CGSize) {
        addConstraint(constraint(forAspect: aspect))
    }
    
    func addConstraint(forTopSpace top: CGFloat, container: UIView) {
        container.addConstraint(container.constraint(forTopSpace: top, container: container))
    }
    
    func addConstraint(forBottomSpace bottom: CGFloat, container: UIView) {
        container.addConstraint(container.constraint(forBottomSpace: bottom, container: container))
    }
    
    func addConstraint(forLeadingSpace leading: CGFloat, container: UIView) {
        container.addConstraint(container.constraint(forLeadingSpace: leading, container: container))
    }
    
    func addConstraint(forTrailingSpace trailing: CGFloat, container: UIView) {
        container.addConstraint(container.constraint(forTrailingSpace: trailing, container: container))
    }
    
    func addConstraint(forCenterY centerY: CGFloat, container: UIView) {
        container.addConstraint(container.constraint(forCenterY: centerY, container: container))
    }
    
    func addConstraint(forCenterX centerX: CGFloat, container: UIView) {
        container.addConstraint(container.constraint(forCenterX: centerX, container: container))
    }
    
    func addConstraints(insets: UIEdgeInsets, childView: UIView) {
        addConstraints([
            childView.constraint(forLeadingSpace: insets.left, container: self),
            childView.constraint(forTrailingSpace: insets.right, container: self),
            childView.constraint(forTopSpace: insets.top, container: self),
            childView.constraint(forBottomSpace: insets.bottom, container: self)
        ])
    }
}