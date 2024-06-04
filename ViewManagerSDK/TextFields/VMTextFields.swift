//
//  VMTextFields.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 03/08/23.
//

import UIKit

//MARK: Protocol VMTextFieldsDelegate
@objc public protocol VMTextFieldsDelegate{
    //Principales
    @objc func VMTxtMiTelcelDidBeginEditing(_ field: VMTextFields)
    @objc func VMTxtMiTelcelDidEndEditing(_ field: VMTextFields)
    @objc func VMTxtMiTelcelChangeCharacter(_ field: VMTextFields, shouldChangeCharactersIn range: NSRange, replacementString string: String)
    
    //Secundarios
    @objc func VMTxtMiTelcelShouldReturn(_ field: VMTextFields)
    @objc func VMTxtMiTelcelShouldBeginEditing(_ field: VMTextFields) -> Bool
}

//MARK: Public CLASS VMTextFields
@IBDesignable
public class VMTextFields: UITextField {
    
    //MARK: - Constantes TextField
//    let textFieldsBundle = Bundle(for: VMTextFields.self)
    
    //MARK: - Variables TextField
    private var typeTxt:EnumTypeTxtBait!
    private var stateTxt:EnumStateTxtBait!
    public var delegateCustom: VMTextFieldsDelegate!
    var plholder: String = ""
    var labelPlaceHold : UILabel!
    var labelTitle : UILabel!
    var viewImg: UIView!
    var imageRigth: UIImageView!
    open var fieldDidEndEditing: ((Bool) -> Void)? = nil
    public var activeLimit: Bool = false
    public var limitCharacters: Int = 0
    //MARK: - Funciones Inicio
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commontInit()
    }
    
    func commontInit(){
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.delegate = self
        if let _ = self.placeholder{
            self.plholder = self.placeholder!
        }
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true
    }

    
    //MARK: - IBInspectables
    @IBInspectable public var typeField: Int = 1 {
        didSet{
            guard let enumValue = EnumTypeTxtBait(rawValue: typeField) else{
                print("Tipo Text field no soportado....")
                return
            }
            typeTxt = enumValue
            self.setUpView()
        }
    }
    
    @IBInspectable public var stateField: Int = 1 {
        didSet{
            guard let enumValue = EnumStateTxtBait(rawValue: stateField) else {
                print("Estado TextField no soportado....")
                return
            }
            
            let colorBorde : UIColor = enumValue.getColorBorde()!
            if #available(iOS 13.0, *) {
                self.traitCollection.performAsCurrent {
                    self.layer.borderColor = colorBorde.cgColor
                }
                self.layer.borderColor = colorBorde.resolvedColor(with: self.traitCollection).cgColor
            } else {
                self.layer.borderColor = colorBorde.cgColor
            }
            
            self.layer.borderWidth = enumValue.getWidthBorder()!
            self.tintColor = enumValue.getColorPrompt()!
            self.textColor = enumValue.getColorTexto()!
            if #available(iOS 11.0, *), self.useTableViewBackgroundColor {
                // Remember to enable `useTableViewBackgroundColor`
                self.backgroundColor = UIColor.baitColor_TextFieldBG()
//                self.backgroundColor = UIColor(named: "simpleStyledTableViewBackgroundColor")
            } else {
                // Fallback on earlier versions
                self.backgroundColor = UIColor.baitColor_TextFieldBG()
            }
            stateTxt = enumValue
//            setUpView()
        }
    }
    public var useTableViewBackgroundColor = false
    
    
    //MARK: - Functions
    func setUpView(){
        switch self.typeTxt {
        case .text?:
            self.isSecureTextEntry = false
            self.autocorrectionType = .no
            self.autocapitalizationType = .sentences
//            self.keyboardType = .asciiCapable
            createLeftViewExtended()
            createRightViewExtended()
        case .phone?:
            self.isSecureTextEntry = false
//            self.autocorrectionType = .no
//            self.autocapitalizationType = .sentences
            self.keyboardType = .numberPad
            limitCharacters = 10
            createLeftView()
        case .psswrd?:
            self.isSecureTextEntry = true
//            self.autocorrectionType = .no
//            self.autocapitalizationType = .sentences
            self.keyboardType = .asciiCapable
//            limitCharacters = 13
            createRigthView()
            createLeftView()
        case .email?:
            self.isSecureTextEntry = false
            self.autocorrectionType = .no
//            self.autocapitalizationType = .sentences
            self.keyboardType = .emailAddress
            createLeftView()
        case .codVal?:
            self.isSecureTextEntry = false
            self.keyboardType = .numberPad
        default:
            print("Tipo textField no seteado...")
        }
    }
    
    public func hideRightView(with bool: Bool){
        rightView?.isHidden = bool
    }
    
    @objc public func isValid()->Bool{
        return typeTxt.isValid(self.text!)!
    }
    
    func createLeftView(){
        let paddingView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func createLeftViewExtended(){
        let paddingView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 50))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func createRightViewExtended(){
//        let paddingView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 50))
        let paddingView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 50))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func createRigthView(){
        viewImg = UIView(frame: CGRect(x: 0, y: 10, width: 50, height: 50))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VMTextFields.tapResponse(tapGestureRecognizer:)))
        viewImg.addGestureRecognizer(tapGestureRecognizer)
        viewImg.isUserInteractionEnabled = true
        switch self.typeTxt {
        case .psswrd?:
            let point: CGPoint = CGPoint(x: (viewImg.frame.width/2)-8, y: (viewImg.frame.height/2)-8)
            imageRigth = UIImageView(frame: CGRect(origin: point, size: CGSize(width: 16, height: 16)))
            imageRigth.contentMode = .scaleAspectFit
            viewImg.addSubview(imageRigth)
            
            //FIXME: Falta cargar las imágenes en Framework
//            var image: String = "icon_view_off"
            if self.isSecureTextEntry {
//                image = "icon_view_off"
                imageRigth.image = UIImage.baitIcon_textViewPassword_hide()
            }else{
//                image = "icon_view_on"
                imageRigth.image = UIImage.baitIcon_textViewPassword_show()
            }
//            guard let eyeDisable = UIImage(named: image, in: textFieldsBundle, compatibleWith: nil) else {
//                fatalError("Missing icon_view_off...")
//            }
//            imageRigth.image = eyeDisable
            
            self.rightView = viewImg
            self.rightViewMode = .always
        default:
            print("Tipo TextField sin imagen a la derecha...")
        }
    }
    
    
    @objc open func tapResponse(tapGestureRecognizer: UITapGestureRecognizer) {
        switch self.typeTxt {
        case .psswrd?:
            if self.isSecureTextEntry{
                DispatchQueue.main.async {
                    self.imageRigth.image = UIImage.baitIcon_textViewPassword_show()
//                    guard let eyeEnable = UIImage(named: "icon_view_on", in: self.textFieldsBundle, compatibleWith: nil) else {
//                        fatalError("Missing icon_view_on...")
//                    }
//                    self.imageRigth.image = eyeEnable
                    self.imageRigth.setNeedsDisplay()
                }
                self.isSecureTextEntry = false
            }else{
                DispatchQueue.main.async {
                    self.imageRigth.image = UIImage.baitIcon_textViewPassword_hide()
//                    guard let eyeDisable = UIImage(named: "icon_view_off", in: self.textFieldsBundle, compatibleWith: nil) else {
//                        fatalError("Missing icon_view_off...")
//                    }
//                    self.imageRigth.image = eyeDisable
                    self.imageRigth.setNeedsDisplay()
                }
                self.isSecureTextEntry = true
            }
        default:
            print("tipo textField sin tapGesture...")
        }
    }
}


//MARK: - extension VMTextFields: UITextFieldDelegate
extension VMTextFields: UITextFieldDelegate{
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        let field = textField as! VMTextFields
        if field.stateField != EnumStateTxtBait.error.rawValue{
            field.stateField = 4
        }
//        field.placeholder = ""
        field.contentVerticalAlignment = .center
        delegateCustom.VMTxtMiTelcelDidBeginEditing(field)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let field = textField as! VMTextFields
        if field.stateField != EnumStateTxtBait.error.rawValue{
            field.stateField = 2
        }
//        field.placeholder = plholder
        if field.text == ""{
            field.contentVerticalAlignment = .center
//            self.animateLabelDown(txtF: field)
        }
        switch self.typeTxt {
//        case .phone?:
//            if !field.isValid(){
//                field.stateField = 5
//            }
//            field.text = field.text?.toPhoneNumberFormat()
        default:
            print("Sin acción al perder foco...")
        }
        delegateCustom.VMTxtMiTelcelDidEndEditing(field)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let field = textField as! VMTextFields
        field.resignFirstResponder()
        delegateCustom.VMTxtMiTelcelShouldReturn(field)
        return true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let field = textField as! VMTextFields
        return delegateCustom.VMTxtMiTelcelShouldBeginEditing(field)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let field = textField as! VMTextFields
        let newLength = textField.text!.count + string.count - range.length
        delegateCustom.VMTxtMiTelcelChangeCharacter(field, shouldChangeCharactersIn: range, replacementString: string)
        switch self.typeTxt {
        case .phone?:
            let characterSet = NSCharacterSet.init(charactersIn: ConstantsTextFields.ACCEPTABLE_CHARACTERS_ASSOCIATE).inverted
            let filtered = string.components(separatedBy: characterSet as CharacterSet).joined(separator: "")
            if string == filtered && newLength <= limitCharacters {
                if  newLength == limitCharacters {
                    self.activeLimit = true
                }else {
                    self.activeLimit = false
                }
                return true
            }
            return false
//        case .psswrd?:
//            let characterSet = NSCharacterSet.init(charactersIn: ConstantsTextFields.ACCEPTABLE_CHARACTERS_SERTEC).inverted
//            let filtered = string.components(separatedBy: characterSet as CharacterSet).joined(separator: "")
//            let newLength = textField.text!.count + string.count - range.length
//            return (newLength >= limitCharacters || string != filtered) ? false : true
//        case .psswrdLogin?:
//            let newLength = textField.text!.count + string.count - range.length
//            return (newLength >= limitCharacters) ? false : true
        default:
            print("TextField sin restricción de longitud...")
            return true
        }
    }
}
