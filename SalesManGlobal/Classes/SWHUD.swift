//
//  File.swift
//  SalesManGlobal
//
//  Created by 谢艳 on 2018/10/30.
//

import Foundation
import MBProgressHUD
extension UIView {
   public  func showTextHud(text:String, autoHide:Bool) -> Void {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .text
        hud.detailsLabel.text = text
        if autoHide {
            hud.hide(animated: true, afterDelay: 1.5)
        }
    }
   public func showLoadingHud(loadingText:String) -> Void {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .indeterminate
        hud.detailsLabel.text = loadingText.count > 0 ? loadingText: "正在加载"
    }
   public func hideHud() -> Void {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
