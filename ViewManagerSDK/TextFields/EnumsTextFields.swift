//
//  EnumsTextFields.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 04/08/23.
//

import Foundation
import UIKit


//MARK: - Enum State TextField
public enum EnumStateTxtBait: Int {
    case inactivo = 1
    case activo = 2
    case deshabilitado = 3
    case focalizado  = 4
    case error = 5
    case success = 6
    case editing = 7
    
    func getColorBorde() -> UIColor? {
        switch self {
        case .inactivo:
            return  UIColor.baitColor_TextFieldInactivoBorde()
        case .activo:
            return UIColor.baitColor_TextFieldActivoBorde()
        case .deshabilitado:
            return UIColor.baitColor_TextFieldDeshabilitadoBorde()
        case .focalizado, .editing:
            return UIColor.baitColor_TextFieldFocalizadoBorde()
        case .error:
            return UIColor.baitColor_TextFieldErrorBorde()
        case .success:
            return UIColor.baitColor_TextFieldSuccessBorde()
        }
    }
    
    func getColorTexto() -> UIColor? {
        switch self {
        case .inactivo:
            return  UIColor.baitColor_TextFieldInactivoTexto()
        case .activo:
            return UIColor.baitColor_TextFieldActivoTexto()
        case .deshabilitado:
            return UIColor.baitColor_TextFieldDeshabilitadoTexto()
        case .focalizado, .editing:
            return UIColor.baitColor_TextFieldFocalizadoTexto()
        case .error:
            return UIColor.baitColor_TextFieldErrorTexto()
        case .success:
            return UIColor.baitColor_TextFieldSuccessTexto()
        }
    }
    
    func getColorTextoTitle() -> UIColor? {
        switch self {
        case .inactivo:
            return  UIColor.baitColor_TextFieldInactivoTextoSecundario()
        case .activo:
            return UIColor.baitColor_TextFieldActivoTextoSecundario()
        case .deshabilitado:
            return  UIColor.baitColor_TextFieldDeshabilitadoTexto()
        case .focalizado, .editing:
            return UIColor.baitColor_TextFieldFocalizadoTextoSecundario()
        case .error:
            return UIColor.baitColor_TextFieldErrorTexto()
        case .success:
            return UIColor.baitColor_TextFieldSuccessTextoSecundario()
        }
    }
    
    func getColorTextoSoporte() -> UIColor? {
        switch self {
        case .inactivo:
            return UIColor.baitColor_TextFieldInactivoTextoSecundario()
        case .activo, .editing:
            return UIColor.baitColor_TextFieldActivoTextoSecundario()
        case .deshabilitado:
            return UIColor.baitColor_TextFieldDeshabilitadoTexto()
        case .focalizado:
            return UIColor.baitColor_TextFieldFocalizadoTextoSecundario()
        case .error:
            return UIColor.baitColor_TextFieldErrorTextoSecundario()
        case .success:
            return UIColor.baitColor_TextFieldSuccessTextoSecundario()
        }
    }
    
    func getColorPrompt() -> UIColor? {
        switch self {
        
        case .focalizado:
            return UIColor.clear
        case .error:
            return UIColor.clear
//            return UIColor.baitColor_TextFieldErrorBorde()
        default:
            return UIColor.clear
        }
    }
    
    func getWidthBorder() -> CGFloat?{
        switch self {
        case .inactivo:
            return 1
        case .activo:
            return 1
        case .deshabilitado:
            return 1
        case .focalizado, .editing:
            return 1
        case .error:
            return 1
        case .success:
            return 1
        }
    }
}


//MARK: - Enum Type TextField
public enum EnumTypeTxtBait: Int{
    case text       = 1
    case phone      = 2
    case psswrd     = 3
    case email      = 4
    case codVal     = 5
    
    func isValid(_ text: String) -> Bool?{
        switch self {
        case .text:
            return isValidText(name: text)
        case .phone:
            return isValidPhone(phone: text)
        case .psswrd:
            return true;
        case .email:
            return isValidEmail(email: text)
        case .codVal:
            return isNumber(number:text)
        }
    }
    
    func isValidText(name:String)->Bool{
        let regex = ConstantsTextFields.RegexText
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: name)
    }
    
    func isValidPhone(phone: String) ->Bool{
        let regex = ConstantsTextFields.RegexTelefono10
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with : phone)
    }
    
    func isValidEmail(email: String) -> Bool{
        let regex = ConstantsTextFields.RegexEmail
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    func isValidName(name: String) -> Bool {
        let regex = ConstantsTextFields.RegexNameUser
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: name)
    }
    
    func isNumber(number:String)->Bool{
        let regex = ConstantsTextFields.RegexNumber
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: number)
    }

    // FIXME: Falta agregar las imágenes al Framework
    /// Obtiene e icono , dependiendo del tipo de textView seleccionado
    /// - Returns: - Retorna un UIImage
    func getImageRigth() -> UIImage? {
        switch self {
        case .psswrd:
            return UIImage.baitIcon_textViewPassword_hide()
//            return UIImage(named: "icon_view_off")
        default:
            return UIImage()
//            return UIImage(named: "emailAlert")
        }
    }
    
    func getTextoSoporteInformativo() -> String? {
        switch self {
        case .text:
            return "Tipo 1: Campo de Texto"
        case .phone:
            return "Tipo 2: Campo de Teléfono"
        case .psswrd:
            return "Tipo 3: Campo Password"
        case .email:
            return "Tipo 4: Campo de Email"
        case .codVal:
            return "Tipo 5: Campo de Código Validación"
        }
    }
}
