//
//  Constants.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 03/08/23.
//

#if canImport(UIKit)
import Foundation
import UIKit

//MARK: - COLORS NAMES BUTTON PRIMARIO
let COLOR_BUTTON_PRIMARIO_ACTIVE_BG : String = "ButtonPrimarioActiveBG"
let COLOR_BUTTON_PRIMARIO_INACTIVE_BG : String = "ButtonPrimarioInactiveBG"
let COLOR_BUTTON_PRIMARIO_ACTIVE_TXT : String = "ButtonPrimarioActiveTXT"
let COLOR_BUTTON_PRIMARIO_INACTIVE_TXT : String = "ButtonPrimarioInactiveTXT"
let COLOR_BUTTON_PRIMARIO_ACTIVE_BORDER : String = "ButtonPrimarioActiveBORDER"
let COLOR_BUTTON_PRIMARIO_INACTIVE_BORDER : String = "ButtonPrimarioInactiveBORDER"

//MARK: - COLORS NAMES BUTTON SECUNDARIO
let COLOR_BUTTON_SECUNDARIO_ACTIVE_BG : String = "ButtonSecundarioActiveBG"
let COLOR_BUTTON_SECUNDARIO_INACTIVE_BG : String = "ButtonSecundarioInactiveBG"
let COLOR_BUTTON_SECUNDARIO_ACTIVE_TXT : String = "ButtonSecundarioActiveTXT"
let COLOR_BUTTON_SECUNDARIO_INACTIVE_TXT : String = "ButtonSecundarioInactiveTXT"

//MARK: - COLORS NAMES BUTTON TEXTO
let COLOR_BUTTON_TEXTO_ACTIVE_BG : String = "ButtonTextoActiveBG"
let COLOR_BUTTON_TEXTO_INACTIVE_BG : String = "ButtonTextoInactiveBG"
let COLOR_BUTTON_TEXTO_ACTIVE_TXT : String = "ButtonTextoActiveTXT"
let COLOR_BUTTON_TEXTO_INACTIVE_TXT : String = "ButtonTextoInactiveTXT"

//MARK: - BORDERS
struct ConstantsButtons{
    static let borderWidthButton : CGFloat     = 1
    static let cornerRadiusButton : CGFloat    = 10
}

//MARK: - COLORS ALERTS
let COLOR_ALERT_WARNING: String = "AlertWarning"
let COLOR_ALERT_WARNING_BG: String = "AlertaWarningBG"

//MARK: - COLORS TEXT FIELDS
//Back Ground
let COLOR_TEXTFIELD_BG : String = "TextFieldBG"
//Place Holder
let COLOR_TEXTFIELD_PLACEHOLDER_DESHABILITADO : String = "TextFieldPlaceholderDeshabilitado"
let COLOR_TEXTFIELD_PLACEHOLDER : String = "TextFieldPlaceholder"
//Texto Secundario
let COLOR_TEXTFIELD_ACTIVO_TEXTO_SECUNDARIO : String = "TextFieldActivoTextoSecundario"
let COLOR_TEXTFIELD_INACTIVO_TEXTO_SECUNDARIO : String = "TextFieldInactivoTextoSecundario"
let COLOR_TEXTFIELD_FOCALIZADO_TEXTO_SECUNDARIO : String = "TextFieldFocalizadoTextoSecundario"
let COLOR_TEXTFIELD_ERROR_TEXTO_SECUNDARIO : String = "TextFieldErrorTextoSecundario"
let COLOR_TEXTFIELD_SUCCESS_TEXTO_SECUNDARIO : String = "TextFieldSuccessTextoSecundario"
//Bordes
let COLOR_TEXTFIELD_INACTIVO_BORDE : String = "TextFieldInactivoBorde"
let COLOR_TEXTFIELD_ACTIVO_BORDE : String = "TextFieldActivoBorde"
let COLOR_TEXTFIELD_DESHABILITADO_BORDE : String = "TextFieldDeshabilitadoBorde"
let COLOR_TEXTFIELD_FOCALIZADO_BORDE : String = "TextFieldFocalizadoBorde"
let COLOR_TEXTFIELD_ERROR_BORDE : String = "TextFieldErrorBorde"
let COLOR_TEXTFIELD_SUCCESS_BORDE : String = "TextFieldSuccessBorder"
//Texto Principal
let COLOR_TEXTFIELD_INACTIVO_TEXTO : String = "TextFieldInactivoTexto"
let COLOR_TEXTFIELD_ACTIVO_TEXTO : String = "TextFieldActivoTexto"
let COLOR_TEXTFIELD_DESHABILITADO_TEXTO : String = "TextFieldDeshabilitadoTexto"
let COLOR_TEXTFIELD_FOCALIZADO_TEXTO : String = "TextFieldFocalizadoTexto"
let COLOR_TEXTFIELD_ERROR_TEXTO : String = "TextFieldErrorTexto"
let COLOR_TEXTFIELD_SUCCESS_TEXTO : String = "TextFieldSuccessTexto"

struct ConstantsTextFields {
    static let RegexText            = "^[-áéíóúÁÉÍÓÚñÑA.'-Za-z0-9 _]+$"
    static let RegexTelefono10      = "\\b\\d{10}\\b"
    static let RegexEmail           = "[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
    static let RegexNameUser        = "^[a-zA-Z_ ]*$"
    static let RegexNumber          = "\\b\\d{1,}\\b"
    
    static let ACCEPTABLE_CHARACTERS_SERTEC     = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    static let ACCEPTABLE_CHARACTERS_ASSOCIATE  = "0123456789"
}
#endif
