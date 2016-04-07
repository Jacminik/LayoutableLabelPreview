//
//  GeometryExtensions.swift
//
//  Created by Masahiro Katsumata on 2015/10/26.
//  Copyright © Masahiro Katsumata. All rights reserved.
//

import UIKit


// MARK: - CGFloat

public extension CGFloat {
    
    public var toRadians: CGFloat {
        return self * CGFloat(M_PI / 180.0)
    }
    public var toDegrees: CGFloat {
        return self * CGFloat(180.0 / M_PI)
    }
    /// 0.5単位の丸め
    public var roundHalf: CGFloat {
        return round(self * 2) / 2
    }
}


// MARK: - CGPoint

public extension CGPoint {
    
    init(_ x: CGFloat, _ y: CGFloat) {
        self.x = x
        self.y = y
    }
    init(_ x: Int, _ y: Int) {
        self.x = CGFloat(x)
        self.y = CGFloat(y)
    }
    init(_ x: Double, _ y: Double) {
        self.x = CGFloat(x)
        self.y = CGFloat(y)
    }
    
    var rounded: CGPoint {
        return CGPoint(round(x), round(y))
    }
    
    func set(x x: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    func set(y y: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    func set(centerSize size: CGSize) -> CGRect {
        return offset(size.width * -0.5, size.height * -0.5) + size
    }
    func offsetX(dx: CGFloat) -> CGPoint {
        return offset(dx, 0.0)
    }
    func offsetY(dy: CGFloat) -> CGPoint {
        return offset(0.0, dy)
    }
    func offset(dx: CGFloat, _ dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
    /// 2点間の距離を求める
    func distance(point: CGPoint) -> CGFloat {
        return sqrt(pow(fabs(x - point.x), 2.0) + pow(fabs(y - point.y), 2.0))
    }
    /// 自身を中心とした円周上の点の位置を求める。
    /// - parameter angle: ラジアン (東:0度から左回りに増加)
    func pointInRadius(radius: CGFloat, angle: Double) -> CGPoint {
        return CGPoint(x: radius * CGFloat(cos(angle)), y: radius * CGFloat(sin(angle)))
    }
}


// MARK: - CGSize

public extension CGSize {
    
    init(_ width: CGFloat, _ height: CGFloat) {
        self.width = width
        self.height = height
    }
    init(_ width: Int, _ height: Int) {
        self.width = CGFloat(width)
        self.height = CGFloat(height)
    }
    init(_ width: Double, _ height: Double) {
        self.width = CGFloat(width)
        self.height = CGFloat(height)
    }
    init(squareSize size: CGFloat) {
        self.width = size
        self.height = size
    }

    
    var rounded: CGSize {
        return CGSize(round(width), round(height))
    }
    var bounds: CGRect {
        return CGPoint.zero + self
    }
    
    func set(width width: CGFloat) -> CGSize {
        return CGSize(width, height)
    }
    func set(height height: CGFloat) -> CGSize {
        return CGSize(width, height)
    }
    func set(center center: CGPoint) -> CGRect {
        return CGRect(center.x - (width * 0.5), center.y - (height * 0.5), width, height);
    }
    func add(width width: CGFloat) -> CGSize {
        return self + CGSize(width, 0.0)
    }
    func add(height height: CGFloat) -> CGSize {
        return self + CGSize(0.0, height)
    }
    func reduce(width width: CGFloat) -> CGSize {
        return self - CGSize(width, 0.0)
    }
    func reduce(height height: CGFloat) -> CGSize {
        return self - CGSize(0.0, height)
    }
    func scaleWidth(scale: CGFloat) -> CGSize {
        return self * CGSize(scale, 1.0)
    }
    func scaleHeight(scale: CGFloat) -> CGSize {
        return self * CGSize(1.0, scale)
    }
    func divideWidth(count: CGFloat) -> CGSize {
        return self / CGSize(count, 1.0)
    }
    func divideHeight(count: CGFloat) -> CGSize {
        return self / CGSize(1.0, count)
    }
}


// MARK: - CGRect

public enum CGRectCorner: Int, CustomStringConvertible {
    case TopLeft = 0, TopRight, BottomLeft, BottomRight
    public var description: String { return ["TopLeft", "TopRight", "BottomLeft", "BottomRight"][rawValue] }
}

public extension CGRect {
    
    init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.origin = CGPoint(x: x, y: y)
        self.size = CGSize(width: width, height: height)
    }
    init(_ x: Int, _ y: Int, _ width: Int, _ height: Int) {
        self.origin = CGPoint(x: CGFloat(x), y: CGFloat(y))
        self.size = CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    init(_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
        self.origin = CGPoint(x: CGFloat(x), y: CGFloat(y))
        self.size = CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    var bounds: CGRect {
        return CGRect(origin: CGPoint.zero, size: size)
    }
    var center: CGPoint {
        return CGPoint(minX + bounds.midX, minY + bounds.midY)
    }
    
    func set(x x: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: x, y: minY), size: size)
    }
    func set(y y: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: minX, y: y), size: size)
    }
    func set(width width: CGFloat) -> CGRect {
        return CGRect(origin: origin, size: CGSize(width: width, height: height))
    }
    func set(height height: CGFloat) -> CGRect {
        return CGRect(origin: origin, size: CGSize(width: width, height: height))
    }
    func set(origin origin: CGPoint) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func set(center center: CGPoint) -> CGRect {
        return center.offset(size.width * -0.5, size.height * -0.5) + size
    }
    func set(size size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func add(x x: CGFloat) -> CGRect {
        return self + CGPoint(x, 0.0)
    }
    func add(y y: CGFloat) -> CGRect {
        return self + CGPoint(0.0, y)
    }
    func add(width width: CGFloat) -> CGRect {
        return self + CGSize(width, 0.0)
    }
    func add(height height: CGFloat) -> CGRect {
        return self + CGSize(0.0, height)
    }
    func offset(x x: CGFloat) -> CGRect {
        return CGRectOffset(self, x, 0.0)
    }
    func offset(y y: CGFloat) -> CGRect {
        return CGRectOffset(self, 0.0, y)
    }
    func offset(x: CGFloat, _ y: CGFloat) -> CGRect {
        return CGRectOffset(self, x, y)
    }
    func reduce(width width: CGFloat) -> CGRect {
        return self - CGSize(width, 0.0)
    }
    func reduce(height height: CGFloat) -> CGRect {
        return self - CGSize(0.0, height)
    }
    func scale(scale: CGFloat) -> CGRect {
        return CGRectApplyAffineTransform(self, CGAffineTransformMakeScale(scale, scale))
    }
    func scaleWidth(scale: CGFloat) -> CGRect {
        return self * CGSize(scale, 1.0)
    }
    func scaleHeight(scale: CGFloat) -> CGRect {
        return self * CGSize(1.0, scale)
    }
    func divideWidth(count: CGFloat) -> CGRect {
        return self / CGSize(count, 1.0)
    }
    func divideHeight(count: CGFloat) -> CGRect {
        return self / CGSize(1.0, count)
    }
    func inset(top top: CGFloat) -> CGRect {
        return origin.offsetY(top) + size.reduce(height: top)
    }
    func cornerPoint(corner: CGRectCorner) -> CGPoint {
        switch corner {
        case .TopLeft: return CGPoint(minX, minY)
        case .TopRight: return CGPoint(maxX, minY)
        case .BottomLeft: return CGPoint(minX, maxY)
        case .BottomRight: return CGPoint(maxX, maxY)
        }
    }
}


// MARK: - Calculate

// MARK: CGPoint vs CGPoint

public func +(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(p1.x + p2.x, p1.y + p2.y)
}
public func -(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(p1.x - p2.x, p1.y - p2.y)
}
public func *(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(p1.x * p2.x, p1.y * p2.y)
}
public func /(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(p1.x / p2.x, p1.y / p2.y)
}
public func +=(inout point: CGPoint, otherPoint: CGPoint) {
    point.x += otherPoint.x
    point.y += otherPoint.y
}
public func -=(inout point: CGPoint, otherPoint: CGPoint) {
    point.x -= otherPoint.x
    point.y -= otherPoint.y
}
public func *=(inout point: CGPoint, otherPoint: CGPoint) {
    point.x *= otherPoint.x
    point.y *= otherPoint.y
}
public func /=(inout point: CGPoint, otherPoint: CGPoint) {
    point.x /= otherPoint.x
    point.y /= otherPoint.y
}


// MARK: CGPoint vs CGSize

public func +(point: CGPoint, size: CGSize) -> CGRect {
    return CGRect(origin: point, size: size)
}


// MARK: CGSize vs CGFloat

public func *(size: CGSize, scale: CGFloat) -> CGSize {
    return CGSize(size.width * scale, size.height * scale)
}
public func /(size: CGSize, count: CGFloat) -> CGSize {
    return CGSize(size.width / count, size.height / count)
}
public func *=(inout size: CGSize, scale: CGFloat) {
    size.width *= scale
    size.height *= scale
}
public func /=(inout size: CGSize, count: CGFloat) {
    size.width /= count
    size.height /= count
}


// MARK: CGSize vs CGSize

public func +(size1: CGSize, size2: CGSize) -> CGSize {
    return CGSize(size1.width + size2.width, size1.height + size2.height)
}
public func -(size1: CGSize, size2: CGSize) -> CGSize {
    return CGSize(size1.width - size2.width, size1.height - size2.height)
}
public func *(size1: CGSize, size2: CGSize) -> CGSize {
    return CGSize(size1.width * size2.width, size1.height * size2.height)
}
public func /(size1: CGSize, size2: CGSize) -> CGSize {
    return CGSize(size1.width / size2.width, size1.height / size2.height)
}
public func +=(inout size: CGSize, otherSize: CGSize) {
    size.width += otherSize.width
    size.height += otherSize.height
}
public func -=(inout size: CGSize, otherSize: CGSize) {
    size.width -= otherSize.width
    size.height -= otherSize.height
}
public func *=(inout size: CGSize, otherSize: CGSize) {
    size.width *= otherSize.width
    size.height *= otherSize.height
}
public func /=(inout size: CGSize, otherSize: CGSize) {
    size.width /= otherSize.width
    size.height /= otherSize.height
}


// MARK: CGRect vs CGPoint

public func +(rect: CGRect, point: CGPoint) -> CGRect {
    return CGRectOffset(rect, point.x, point.y)
}
public func -(rect: CGRect, point: CGPoint) -> CGRect {
    return CGRectOffset(rect, -point.x, -point.y)
}
public func *(rect: CGRect, point: CGPoint) -> CGRect {
    return CGRect(origin: CGPoint(x: rect.minY * point.x, y: rect.minY * point.y), size: CGSize(width: rect.width, height: rect.height))
}
public func /(rect: CGRect, point: CGPoint) -> CGRect {
    return CGRect(origin: CGPoint(x: rect.minY / point.x, y: rect.minY / point.y), size: CGSize(width: rect.width, height: rect.height))
}
public func +=(inout rect: CGRect, point: CGPoint) {
    rect.origin.x += point.x
    rect.origin.y += point.y
}
public func -=(inout rect: CGRect, point: CGPoint) {
    rect.origin.x -= point.x
    rect.origin.y -= point.y
}
public func *=(inout rect: CGRect, point: CGPoint) {
    rect.origin.x *= point.x
    rect.origin.y *= point.y
}
public func /=(inout rect: CGRect, point: CGPoint) {
    rect.origin.x *= point.x
    rect.origin.y *= point.y
}


// MARK: CGRect vs CGSize

public func +(rect: CGRect, size: CGSize) -> CGRect {
    return CGRect(origin: rect.origin, size: CGSize(width: rect.width + size.width, height: rect.height + size.height))
}
public func -(rect: CGRect, size: CGSize) -> CGRect {
    return CGRect(origin: rect.origin, size: CGSize(width: rect.width - size.width, height: rect.height - size.height))
}
public func *(rect: CGRect, size: CGSize) -> CGRect {
    return CGRect(origin: rect.origin, size: CGSize(width: rect.width * size.width, height: rect.height * size.height))
}
public func /(rect: CGRect, size: CGSize) -> CGRect {
    return CGRect(origin: rect.origin, size: CGSize(width: rect.width / size.width, height: rect.height / size.height))
}
public func +=(inout rect: CGRect, size: CGSize) {
    rect.size.width += size.width
    rect.size.height += size.height
}
public func -=(inout rect: CGRect, size: CGSize) {
    rect.size.width -= size.width
    rect.size.height -= size.height
}
public func *=(inout rect: CGRect, size: CGSize) {
    rect.size.width *= size.width
    rect.size.height *= size.height
}
public func /=(inout rect: CGRect, size: CGSize) {
    rect.size.width /= size.width
    rect.size.height /= size.height
}


// MARK: - CGAffineTransform

public extension CGAffineTransform {
    
    var angle: CGFloat {
        return atan2(b, a)
    }
    var scale: CGPoint {
        return CGPoint(sqrt(a * a + c * c), sqrt(b * b + d * d))
    }
}

public func CGATranslateIdentity(tx: CGFloat, _ ty: CGFloat) -> CGAffineTransform {
    return CGAffineTransformTranslate(CGAffineTransformIdentity, tx, ty)
}
public func CGATranslateIdentityX(tx: CGFloat) -> CGAffineTransform {
    return CGATranslateIdentity(tx, 0.0)
}
public func CGATranslateIdentityY(ty: CGFloat) -> CGAffineTransform {
    return CGATranslateIdentity(0.0, ty)
}
public func CGATranslateIdentityScale(scale: CGFloat) -> CGAffineTransform {
    return CGAffineTransformScale(CGAffineTransformIdentity, scale, scale)
}
public func CGATranslateIdentityScale(sx: CGFloat, sy: CGFloat) -> CGAffineTransform {
    return CGAffineTransformScale(CGAffineTransformIdentity, sx, sy)
}
public func CGATranslateIdentityRotate(angle: CGFloat) -> CGAffineTransform {
    return CGAffineTransformRotate(CGAffineTransformIdentity, angle)
}


// MARK: - UIEdgeInsets

extension UIEdgeInsets {
    
    public static let zero = UIEdgeInsetsZero
    public init(v: CGFloat, h: CGFloat) {
        self.init(top: v, left: h, bottom: v, right: h)
    }
    
    public var inverse: UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
    public func apply(rect: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(rect, self)
    }
}
