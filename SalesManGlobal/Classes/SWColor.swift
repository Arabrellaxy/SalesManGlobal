//
//  SWColor.swift
//  SalesManLogin_Example
//
//  Created by 谢艳 on 2018/10/23.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    public  class func swGrayTextColor() -> UIColor {
        return UIColor.init(red: 191.997/255.0, green: 191.997/255.0, blue: 191.997/255.0, alpha: 1.0)
    }
    public  class func swDarkTextColor() -> UIColor {
        return UIColor.init(red: 65.9991/255.0, green: 65.9991/255.0, blue: 65.9991/255.0, alpha: 1.0)
    }
    public  class func swThemeColor() -> UIColor {
        return UIColor.init(red: 1, green: 93/255.0, blue: 0, alpha: 1.0)
    }
    public  class func swGreyColor() -> UIColor {
        return UIColor.init(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1.0)
    }
    public  class func swLightGreyColor() -> UIColor {
        return UIColor.init(red: 191.997/255.0, green: 191.997/255.0, blue: 191.997/255.0, alpha: 1.0)
    }
    public  class func swCategoryGreyColor() -> UIColor {
        return UIColor.init(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1.0)
    }
    public  class func swCategoryGreyTextColor() -> UIColor {
        return UIColor.init(red: 152/255.0, green: 152/255.0, blue: 152/255.0, alpha: 1.0)
    }
    public  class func swColorWithHexValue(hexValue:Int) -> UIColor {
        return UIColor.init(red:((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0,
                            green:((CGFloat)((hexValue & 0x00FF00) >>  8))/255.0,
                            blue:((CGFloat)((hexValue & 0x0000FF) >>  0))/255.0,
                            alpha:1.0)
    }
}
