//
//  VMButtonsBait.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 03/08/23.
//

import Foundation
import UIKit

/// Colección de botones View Manager
/// - 1 - Botón principal: Título negro y BG amarillo
/// - 2 - Botón sin definir
/// - 3 - Botón de texto: Titulo negro y sin contorno
public enum typeButtonEnum :Int{
    case buttonPrimario = 1
    case buttonSecundario = 2
    case buttonTexto = 3
    
    /// Obtiene el color del background del botón, dependiendo del tipo de botón seleccionado y de su estado
    /// - Parameter isActive: - Botón activo / inactivo
    /// - Returns: - Retorna un UIColor
    func getColorBackground(isActive:Bool) -> UIColor{
        if (isActive){
            switch self {
            case .buttonPrimario:
                return UIColor.baitColor_buttonPrimarioActiveBG()
            case .buttonSecundario:
                return UIColor.clear
//                return UIColor.baitColor_buttonSecundarioBG()
            case .buttonTexto:
                return UIColor.clear
//                return UIColor.baitColor_buttonSecundarioBG()
            }
        } else {
            switch self {
            case .buttonPrimario:
                return UIColor.baitColor_buttonPrimarioInactiveBG()
            case .buttonSecundario:
                return UIColor.baitColor_buttonSecundarioInactiveBG()
            case .buttonTexto:
                return UIColor.baitColor_buttonSecundarioInactiveBG()
            }
        }
    }
    
    /// Obtiene el color del título del botón, dependiendo del tipo de botón seleccionado y de su estado
    /// - Parameter isActive: - Botón activo / inactivo
    /// - Returns: - Retorna un UIColor
    func getColorTitle(isActive:Bool) -> UIColor{
        if (isActive){
            switch self {
            case .buttonPrimario:
                return UIColor.baitColor_buttonPrimarioActiveTXT()
            case .buttonSecundario:
                return UIColor.baitColor_buttonSecundarioActiveTXT()
            case .buttonTexto:
                return UIColor.baitColor_buttonTextoActiveTXT()
            }
        }else{
            switch self {
            case .buttonPrimario:
                return UIColor.baitColor_buttonPrimarioInactiveTXT()
            case .buttonSecundario:
                return UIColor.baitColor_buttonSecundarioInactiveTXT()
            case .buttonTexto:
                return UIColor.baitColor_buttonTextoInactiveTXT()
            }
        }
    }
    
    /// Obtiene el color del borde del botón, dependiendo del tipo de botón seleccionado y de su estado
    /// - Parameter isActive: - Botón activo / inactivo
    /// - Returns: - Retorna un UIColor
    func getColorBorder(isActive:Bool) -> UIColor{
        if (isActive){
            switch self {
            case .buttonPrimario:
                //return UIColor.baitColor_buttonPrimarioActiveBORDER()
                return UIColor.clear
            case .buttonSecundario:
                return UIColor.clear
            case .buttonTexto:
                return UIColor.clear
            }
        }else{
            switch self {
            case .buttonPrimario:
                return UIColor.baitColor_buttonPrimarioInactiveBORDER()
            case .buttonSecundario:
                return UIColor.clear
            case .buttonTexto:
                return UIColor.clear
            }
        }
    }
    
    
    /// Obtiene la fuente del título del botón, dependiendo del tipo de botón seleccionado
    /// - Returns: - Retorna un UIFont
    func getFontTitle() -> UIFont{
        switch self {
        case .buttonPrimario:
            return UIFont(name: FONT_BOGLE_BOLD, size: 16.0) ?? .systemFont(ofSize: 14)
        default:
            return UIFont(name: FONT_BOGLE_REGULAR, size: 14.0) ?? .systemFont(ofSize: 12)
        }
    }
    
}


//MARK: - Elemento IBDesignable
/// Custom Button Bait ViewManagerSDK
/// - typeButton (Int): Tipo de botón a implementar (1,2,3...)
/// - activeButton (Bool): Estado del botón
@IBDesignable public class VMButtonsMiBait: UIButton {
    
    var _type : typeButtonEnum = typeButtonEnum.buttonPrimario
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.bounds = bounds
    }
    
    
    //MARK: - Propiedades IBInspectables
    @IBInspectable
    /// - 1 - Botón principal: Título negro y BG amarillo
    /// - 2 - Botón sin definir
    /// - 3 - Botón de texto: Titulo negro y sin contorno
    public var typeButton: Int = 1 {
        didSet {
            guard let enumValue = typeButtonEnum(rawValue: typeButton) else {
                print("Unsupported type....")
                return
            }
            _type = enumValue
            
            if _type == .buttonSecundario || _type == .buttonTexto{
                let underlineAttribute: [NSAttributedString.Key: Any] = [
                      .underlineStyle: NSUnderlineStyle.single.rawValue
                  ]
                
                let attributeString = NSMutableAttributedString(
                    string: (self.titleLabel?.text)!,
                        attributes: underlineAttribute
                     )
                self.setAttributedTitle(attributeString, for: .normal)
            }
            
            
            self.titleLabel?.font = _type.getFontTitle()
            self.layer.borderWidth = ConstantsButtons.borderWidthButton
            self.layer.cornerRadius = self.bounds.height / 2
        }
    }
    
    @IBInspectable
    public var activeButton: Bool {
        get {
            return true
        }
        set {
            self.isUserInteractionEnabled = newValue
            self.setTitleColor(_type.getColorTitle(isActive: newValue), for: .normal)
            self.backgroundColor = _type.getColorBackground(isActive: newValue)
            self.titleLabel?.font = _type.getFontTitle()
            
            let colorBorde : UIColor = _type.getColorBorder(isActive: newValue)
            if #available(iOS 13.0, *) {
                self.traitCollection.performAsCurrent {
                    self.layer.borderColor = colorBorde.cgColor
                }
            } else {
                self.layer.borderColor = colorBorde.cgColor
            }
        }
    }
}
