//
//  VMUIImageExtensions.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 04/08/23.
//

#if canImport(UIKit)
import Foundation
import UIKit

func getAlertsIcons(nombre:String) -> UIImage {
    // Una propiedad global para una fácil referencia
    let bundle = Bundle(for: VMGenericAlert.self)
    if #available(iOS 11.0, *) {
        return UIImage(named: nombre, in: bundle, compatibleWith: nil) ?? UIImage()
    }else{
        return UIImage()
    }
}

func getTextViewsIcons(nombre:String) -> UIImage {
    // Una propiedad global para una fácil referencia
    let bundle = Bundle(for: VMTextFields.self)
    if #available(iOS 11.0, *) {
        return UIImage(named: nombre, in: bundle, compatibleWith: nil) ?? UIImage()
    }else{
        return UIImage()
    }
}

@objc public extension UIImage{
    //MARK: - ICONS ALERT WARNING
    class func baitIcon_alertWarning() -> UIImage{
        return getAlertsIcons(nombre: ICON_ALERT_WARNING)
    }
    
    //MARK: - ICONS TEXT VIEWS
    //Password
    class func baitIcon_textViewPassword_show() -> UIImage{
        return getTextViewsIcons(nombre: ICON_TEXTVIEW_PWD_SHOW)
    }
    class func baitIcon_textViewPassword_hide() -> UIImage{
        return getTextViewsIcons(nombre: ICON_TEXTVIEW_PWD_HIDE)
    }
    
}
#endif
