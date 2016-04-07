//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let view = Preview(frame: CGRect(x: 0, y: 0, width: 600, height: 1000))
let firstLabel = view.labels![0], secondLabel = view.labels![1], thirdLabel = view.labels![2]




/*** ここをいじって確認 ***/

firstLabel.setLayout(weight: .Bold, lineSpacing: 3, letterSpacing: -4)
secondLabel.setLayout(lineSpacing: 0, letterSpacing: 0)
thirdLabel.setLayout(lineSpacing: 19, letterSpacing: 40)

/*** ここまで ***/

/* 調整可能なプロパティ

setLayout(
    fontSize: <#T##CGFloat?#>,
    weight: <#T##FontInfo.Weight#>,
    lineSpacing: <#T##CGFloat#>,
    letterSpacing: <#T##CGFloat#>,
    sideInset: <#T##CGFloat#>,
    topInset: <#T##CGFloat#>,
    indent: <#T##CGFloat#>
)

*/

view.setNeedsLayout()
XCPlaygroundPage.currentPage.liveView = view
