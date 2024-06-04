//
//  VMUIColorExtensions.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 03/08/23.
//

import Foundation
import UIKit

func getVersionColor(nombre:String) -> UIColor {
    // Una propiedad global para una fácil referencia
    
    let bundle = Bundle(for: VMButtonsMiBait.self)
    if #available(iOS 11.0, *) {
        return  UIColor(named: nombre, in: bundle, compatibleWith: nil) ?? UIColor.systemPink
    }else{
        return UIColor.clear
    }
}

func getAlertsColors(nombre:String) -> UIColor {
    // Una propiedad global para una fácil referencia
    
    let bundle = Bundle(for: VMGenericAlert.self)
    if #available(iOS 11.0, *) {
        return  UIColor(named: nombre, in: bundle, compatibleWith: nil) ?? UIColor.systemPink
    }else{
        return UIColor.clear
    }
}


@objc public extension UIColor{
    
    //MARK: - COLORS BUTTON PRIMARIO
    //BackGround
    class func baitColor_buttonPrimarioActiveBG() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_PRIMARIO_ACTIVE_BG)
    }
    class func baitColor_buttonPrimarioInactiveBG() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_PRIMARIO_INACTIVE_BG)
    }
    //Título
    class func baitColor_buttonPrimarioActiveTXT() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_PRIMARIO_ACTIVE_TXT)
    }
    class func baitColor_buttonPrimarioInactiveTXT() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_PRIMARIO_INACTIVE_TXT)
    }
    //Borde
    class func baitColor_buttonPrimarioActiveBORDER() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_PRIMARIO_ACTIVE_BORDER)
    }
    class func baitColor_buttonPrimarioInactiveBORDER() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_PRIMARIO_INACTIVE_BORDER)
    }
    
    //MARK: - COLORS BUTTON SECUNDARIO
    //BackGround
    class func baitColor_buttonSecundarioBG() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_SECUNDARIO_ACTIVE_BG)
    }
    class func baitColor_buttonSecundarioInactiveBG() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_SECUNDARIO_INACTIVE_BG)
    }
    //Título
    class func baitColor_buttonSecundarioActiveTXT() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_SECUNDARIO_ACTIVE_TXT)
    }
    class func baitColor_buttonSecundarioInactiveTXT() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_SECUNDARIO_INACTIVE_TXT)
    }
    
    //MARK: - COLORS BUTTON TEXTO
    //BackGround
    class func baitColor_buttonTextoBG() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_TEXTO_ACTIVE_BG)
    }
    class func baitColor_buttonTextoInactiveBG() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_TEXTO_INACTIVE_BG)
    }
    //Título
    class func baitColor_buttonTextoActiveTXT() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_TEXTO_ACTIVE_TXT)
    }
    class func baitColor_buttonTextoInactiveTXT() -> UIColor{
        return getVersionColor(nombre: COLOR_BUTTON_TEXTO_INACTIVE_TXT)
    }
    
    //MARK: - COLORS ALERT WARNING
    //Border
    class func baitColor_alertWarningBORDER() -> UIColor{
        return getAlertsColors(nombre: COLOR_ALERT_WARNING)
    }
    
    //BackGround
    class func baitColor_alertWarningBG() -> UIColor{
        return getAlertsColors(nombre: COLOR_ALERT_WARNING_BG)
    }
    
    //MARK: - COLORS TEXT FIELD
    //BackGround
    @objc class func baitColor_TextFieldBG() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_BG)
    }
    
    //Place Holder
    @objc class func baitColor_TextFieldPlaceholderDeshabilitado() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_PLACEHOLDER_DESHABILITADO)
    }
    
    @objc class func baitColor_TextFieldPlaceholder() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_PLACEHOLDER)
    }
    
    //Texto Soporte
    class func baitColor_TextFieldActivoTextoSecundario() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_ACTIVO_TEXTO_SECUNDARIO)
    }
    class func baitColor_TextFieldInactivoTextoSecundario() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_INACTIVO_TEXTO_SECUNDARIO)
    }
    class func baitColor_TextFieldFocalizadoTextoSecundario() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_FOCALIZADO_TEXTO_SECUNDARIO)
    }
    class func baitColor_TextFieldErrorTextoSecundario() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_ERROR_TEXTO_SECUNDARIO)
    }
    class func baitColor_TextFieldSuccessTextoSecundario() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_SUCCESS_TEXTO_SECUNDARIO)
    }
    
    //Bordes
    class func baitColor_TextFieldInactivoBorde() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_INACTIVO_BORDE)
    }
    class func baitColor_TextFieldActivoBorde() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_ACTIVO_BORDE)
    }
    class func baitColor_TextFieldDeshabilitadoBorde() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_DESHABILITADO_BORDE)
    }
    class func baitColor_TextFieldFocalizadoBorde() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_FOCALIZADO_BORDE)
    }
    class func baitColor_TextFieldErrorBorde() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_ERROR_BORDE)
    }
    class func baitColor_TextFieldSuccessBorde() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_SUCCESS_BORDE)
    }
    
    //Texto Principal
    class func baitColor_TextFieldInactivoTexto() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_INACTIVO_TEXTO)
    }
    class func baitColor_TextFieldActivoTexto() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_ACTIVO_TEXTO)
    }
    class func baitColor_TextFieldDeshabilitadoTexto() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_DESHABILITADO_TEXTO)
    }
    class func baitColor_TextFieldFocalizadoTexto() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_FOCALIZADO_TEXTO)
    }
    class func baitColor_TextFieldErrorTexto() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_ERROR_TEXTO)
    }
    class func baitColor_TextFieldSuccessTexto() -> UIColor {
        return getVersionColor(nombre: COLOR_TEXTFIELD_SUCCESS_TEXTO)
    }
    
    
}
