//
//  SWButton.swift
//  SalesManGlobal
//
//  Created by 谢艳 on 2018/11/14.
//

import UIKit

extension UIButton {

    public func verticalAlignmentWithTitleTop(titleTop:Bool,space:CGFloat){
        self.resetEdgeInsets()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        let contentRect = self.contentRect(forBounds: self.bounds)
        let titleSize = self.titleRect(forContentRect: contentRect).size
        let imageSize = self.imageRect(forContentRect: contentRect).size
        let halfWidth = (titleSize.width + imageSize.width)/2
        let halfHeight = (titleSize.height + imageSize.height)/2
        let topInset = min(halfHeight, titleSize.height)
        let leftInset = (titleSize.width - imageSize.width) > 0 ? (titleSize.width - imageSize.width) / 2 : 0
        let bottomInset = (titleSize.height - imageSize.height)>0 ? (titleSize.height - imageSize.height)/2 : 0
        let rightInset = min(halfWidth, titleSize.width)
        if titleTop {
            self.titleEdgeInsets = UIEdgeInsets.init(top: -halfHeight-space, left: -halfWidth, bottom: halfHeight+space, right: halfWidth)
            self.contentEdgeInsets = UIEdgeInsets.init(top: topInset+space, left: leftInset, bottom: -bottomInset, right: -rightInset)
        }else {
            self.titleEdgeInsets = UIEdgeInsets.init(top: halfHeight+space, left: -halfWidth, bottom: -halfHeight-space, right: halfWidth)
            self.contentEdgeInsets = UIEdgeInsets.init(top: -bottomInset, left: leftInset, bottom: topInset+space, right: -rightInset)
        }
    }
    public  func horizontalTitleImage(space:CGFloat) {
        self.resetEdgeInsets()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        let contentRect = self.contentRect(forBounds: self.bounds)
        let titleSize = self.titleRect(forContentRect: contentRect).size
        let imageSize = self.imageRect(forContentRect: contentRect).size
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, space)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, 0, imageSize.width)
        self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width+space, 0, -titleSize.width-space)
    }
    public func horizontalImageTitle(space:CGFloat) {
        self.resetEdgeInsets()
        self.titleEdgeInsets = UIEdgeInsetsMake(0, space, 0, -space)
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, space)
    }
    func resetEdgeInsets() {
        self.contentEdgeInsets = UIEdgeInsets.zero
        self.imageEdgeInsets = UIEdgeInsets.zero
        self.titleEdgeInsets = .zero
        
    }
    
}
