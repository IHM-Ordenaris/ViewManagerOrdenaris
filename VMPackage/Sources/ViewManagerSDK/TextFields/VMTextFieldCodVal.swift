//
//  VMTextFieldCodVal.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 07/08/23.
//

#if canImport(UIKit)
import Foundation
import UIKit

public class VMTextFieldCodVal: UITextField {

    private var typeTxt:EnumTypeTxtBait!
    private var stateTxt:EnumStateTxtBait!
    
    open var fieldDidEndEditing: ((Bool) -> Void)? = nil
    public var chare:String = ""
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commontInit()
    }

    
    func commontInit(){
        typeTxt = EnumTypeTxtBait(rawValue: 5)
        stateTxt = EnumStateTxtBait(rawValue: 1)
        
        self.tintColor = UIColor.darkGray
        self.layer.borderColor = stateTxt.getColorBorde()?.cgColor
        self.layer.borderWidth = stateTxt.getWidthBorder()!
        self.textAlignment = .center
        self.contentVerticalAlignment = .center
        self.font = UIFont(name: FONT_GOTHAM_BOLD, size: 28.0) ?? .systemFont(ofSize: 26)
        self.textColor = UIColor.baitColor_TextFieldActivoTexto()
        self.delegate = self
        self.tintColor = UIColor.white
        self.addTarget(self, action: #selector(VMTextFieldCodVal.editingChanged), for: .editingChanged)
        self.keyboardType = .numberPad
    }
    
    func reloadComponent(){
        self.layer.borderColor = stateTxt.getColorBorde()?.cgColor
        self.layer.borderWidth = stateTxt.getWidthBorder()!
    }
    
    @objc open func editingChanged() {
        if self.tag != 1 && self.text == ""{
            self.resignFirstResponder()
            self.fieldDidEndEditing?(false)
        }
        if self.text?.count == 1{
            if typeTxt.isValid(self.text!)!{
                self.resignFirstResponder()
                self.fieldDidEndEditing?(true)
            }
        }
    }
    
    public func isValid()->Bool{
        return typeTxt.isValid(self.text!)!
    }
    
}

extension VMTextFieldCodVal: UITextFieldDelegate{
    
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        let field = textField as! VMTextFieldCodVal
        field.stateTxt = .activo
        field.reloadComponent()
    }
    
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let field = textField as! VMTextFieldCodVal
        field.stateTxt = .inactivo
        field.reloadComponent()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let char = string.cString(using: String.Encoding.utf8)
        let isBackSpace: Int = Int(strcmp(char, "\u{8}"))
        if isBackSpace == -8 {
            print("Backspace was pressed")
            
            return true
        }else{
            
            if textField.text != ""{
                
                self.text = string
                self.fieldDidEndEditing?(true)
                
                return false
            }else{
                
               
                switch self.typeTxt {
                case .codVal:
                    guard let text = textField.text else { return true }
                    let newLength = text.count + string.count - range.length
                    return newLength <= 1
                default:
                    print("no controladoo...")
                    return true
                }
            }
        }
    }
}
#endif
