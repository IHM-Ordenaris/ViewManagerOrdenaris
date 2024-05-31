//
//  VMValidateCode.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 15/08/23.
//

#if canImport(UIKit)
import UIKit

@objc public protocol VMValidateCodeDelegateExterno{
    @objc func VMTxtMiBaitDidBeginEditingEx(_ field: UITextField)
    @objc func VMTxtMiBaitDidEndEditingEx(_ field: UITextField, customDelete: Bool)
    @objc optional func VMTxtMiBaitChangeCharacterEx(_ field: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)
    @objc func VMTxtMiBaitShouldReturnEx(_ field: UITextField)
    @objc optional func VMTxtMiBaitShouldBeginEditingEx(_ field: UITextField) -> Bool
}

enum tipoPIN: String{
    case pinOne = "pinUno"
    case pinTwo = "pinDos"
    case pinThree = "pinTres"
    case pinFour = "pinCuatro"
    case pinFive = "pinCinco"
    case pinSix = "pinSeis"
}

@IBDesignable public class VMValidateCode: UIView {
    
    //MARK: - Variables
    var contentView: UIView!
    let bordeWidt : CGFloat = 1
    let bordeColor : CGColor = UIColor.black.cgColor
    let corneRadius : CGFloat = 8
    public var superTextField: MyTextField = MyTextField()
    var newView: UIView = UIView()
    public var newCode:String = ""
    var pinComplete:((_ pincode: String) -> Void)? = nil
    
    var letter:String = ""
    public var arrayPin:[String] = ["","","","","",""]
    var isTextoLargo: Bool = false
    
    var isCustomDelete:Bool = false
    //MARK: - Variables
    static var stateFieldStatic = 0
    @objc public var delegateExterno: VMValidateCodeDelegateExterno!

    //MARK: - IBOutlets
    @IBOutlet weak var viewToSuperField: UIView!
    
    @IBOutlet weak var viewUno: UIView!
    @IBOutlet weak var pinUno: UITextField!
    @IBOutlet weak var viewDos: UIView!
    @IBOutlet weak var pinDos: UITextField!
    @IBOutlet weak var viewTres: UIView!
    @IBOutlet weak var pinTres: UITextField!
    @IBOutlet weak var viewCuatro: UIView!
    @IBOutlet weak var pinCuatro: UITextField!
    @IBOutlet weak var viewCinco: UIView!
    @IBOutlet weak var pinCinco: UITextField!
    @IBOutlet weak var viewSeis: UIView!
    @IBOutlet weak var pinSeis: UITextField!
    @IBOutlet weak var viewSoporte: UIView!
    @IBOutlet weak var labelSoporte: UILabel!
    
    //MARK: - Funciones Inicio
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    
    public override func layoutSubviews() {
        self.layoutIfNeeded()
        self.contentView.layer.masksToBounds = true
        self.setStyleTextFields()
    }
    
    //MARK: - Propiedades Inspectables
    @IBInspectable public var estadoCampo: Int = 1 {
        didSet{
            guard let enumValue = EnumStateTxtBait(rawValue: estadoCampo) else {
                print("Estado TextField no soportado....")
                return
            }
            VMValidateCode.stateFieldStatic = estadoCampo
            
            let colorBorde : UIColor = enumValue.getColorBorde()!
            if #available(iOS 13.0, *) {
                self.traitCollection.performAsCurrent {
                    self.pinUno.layer.borderColor = colorBorde.cgColor
                    self.pinDos.layer.borderColor = colorBorde.cgColor
                    self.pinTres.layer.borderColor = colorBorde.cgColor
                    self.pinCuatro.layer.borderColor = colorBorde.cgColor
                    self.pinCinco.layer.borderColor = colorBorde.cgColor
                    self.pinSeis.layer.borderColor = colorBorde.cgColor
                }
                self.pinUno.layer.borderColor = colorBorde.resolvedColor(with: self.traitCollection).cgColor
                self.pinDos.layer.borderColor = colorBorde.resolvedColor(with: self.traitCollection).cgColor
                self.pinTres.layer.borderColor = colorBorde.resolvedColor(with: self.traitCollection).cgColor
                self.pinCuatro.layer.borderColor = colorBorde.resolvedColor(with: self.traitCollection).cgColor
                self.pinCinco.layer.borderColor = colorBorde.resolvedColor(with: self.traitCollection).cgColor
                self.pinSeis.layer.borderColor = colorBorde.resolvedColor(with: self.traitCollection).cgColor
            } else {
                self.pinUno.layer.borderColor = colorBorde.cgColor
                self.pinDos.layer.borderColor = colorBorde.cgColor
                self.pinTres.layer.borderColor = colorBorde.cgColor
                self.pinCuatro.layer.borderColor = colorBorde.cgColor
                self.pinCinco.layer.borderColor = colorBorde.cgColor
                self.pinSeis.layer.borderColor = colorBorde.cgColor
            }
            
            self.pinUno.layer.borderWidth = enumValue.getWidthBorder()!
            self.pinUno.tintColor = enumValue.getColorPrompt()!
            self.pinUno.textColor = enumValue.getColorTexto()!
            
            self.pinDos.layer.borderWidth = enumValue.getWidthBorder()!
            self.pinDos.tintColor = enumValue.getColorPrompt()!
//            self.pinDos.textColor = enumValue.getColorTexto()!
            
            self.pinTres.layer.borderWidth = enumValue.getWidthBorder()!
            self.pinTres.tintColor = enumValue.getColorPrompt()!
//            self.pinTres.textColor = enumValue.getColorTexto()!
            
            self.pinCuatro.layer.borderWidth = enumValue.getWidthBorder()!
            self.pinCuatro.tintColor = enumValue.getColorPrompt()!
//            self.pinCuatro.textColor = enumValue.getColorTexto()!
            
            self.pinCinco.layer.borderWidth = enumValue.getWidthBorder()!
            self.pinCinco.tintColor = enumValue.getColorPrompt()!
//            self.pinCinco.textColor = enumValue.getColorTexto()!
            
            self.pinSeis.layer.borderWidth = enumValue.getWidthBorder()!
            self.pinSeis.tintColor = enumValue.getColorPrompt()!
//            self.pinSeis.textColor = enumValue.getColorTexto()!
            
            if self.estadoCampo == EnumStateTxtBait.error.rawValue{
                self.viewSoporte.isHidden = false
            }else{
                self.viewSoporte.isHidden = true
            }
            self.labelSoporte.textColor = enumValue.getColorTextoSoporte()!
        }
    }
    
    @IBInspectable public var textoSoporte: String = "" {
        didSet{
            self.labelSoporte.text = ""
            if textoSoporte != ""{
                self.labelSoporte.text = textoSoporte
            }
        }
    }
    
    @IBInspectable public var tipoTeclado: UIKeyboardType = .asciiCapable {
        didSet{
            if self.isCustomDelete{
                self.pinUno.keyboardType = tipoTeclado
                self.pinDos.keyboardType = tipoTeclado
                self.pinTres.keyboardType = tipoTeclado
                self.pinCuatro.keyboardType = tipoTeclado
                self.pinCinco.keyboardType = tipoTeclado
                self.pinSeis.keyboardType = tipoTeclado
                self.pinUno.becomeFirstResponder()
            }else{
                self.superTextField.keyboardType = tipoTeclado
                self.superTextField.becomeFirstResponder()
            }
        }
    }
    
    /// Variable que maneja el tipo de borrado -  true: borrado por casilla / false: borrado de Der a Izq
    @IBInspectable public var customDelete: Bool = false {
        didSet{
            self.isCustomDelete = customDelete
            if self.isCustomDelete{
                self.configTextFields()
            }else{
                self.initTextGeneric()
            }
        }
    }

    
    //MARK: - Funciones Controller
    private func setUpView() {
        self.arrayPin.removeAll()
        self.arrayPin = ["","","","","",""]
        self.delegateExterno = self
        self.contentView = loadViewFromNib()
        self.contentView.frame = bounds
        self.contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.backgroundColor = .clear
        addSubview(self.contentView)
        
//        if self.isCustomDelete{
//            self.configTextFields()
//        }else{
//            self.initTextGeneric()
//        }
    }
    
    public func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: VMValidateCode.self)
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func configTextFields(){
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(tapGestureView1))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(tapGestureView2))
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(tapGestureView3))
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(tapGestureView4))
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(tapGestureView5))
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(tapGestureView6))
        self.viewUno.addGestureRecognizer(tapGesture1)
        self.viewDos.addGestureRecognizer(tapGesture2)
        self.viewTres.addGestureRecognizer(tapGesture3)
        self.viewCuatro.addGestureRecognizer(tapGesture4)
        self.viewCinco.addGestureRecognizer(tapGesture5)
        self.viewSeis.addGestureRecognizer(tapGesture6)
    }
    
    func initTextGeneric(){
        superTextField.frame = self.viewToSuperField.bounds
        superTextField.textAlignment = NSTextAlignment.center
        superTextField.textColor = UIColor.clear//UIColor(named: "inputFondo")
        superTextField.tintColor = UIColor.white
        superTextField.translatesAutoresizingMaskIntoConstraints = true
        self.viewToSuperField.addSubview( superTextField )
        self.viewToSuperField.backgroundColor = UIColor.clear
        superTextField.addTarget(self, action: #selector(fnIniciarEdicion), for: .editingChanged)
        
        newView.frame = self.bounds
        newView.backgroundColor = UIColor.clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        newView.addGestureRecognizer(tapGesture)
        self.addSubview( newView )
    }
    
    func setStyleTextFields(){
        self.pinUno.layer.borderWidth = bordeWidt
        self.pinUno.layer.borderColor = bordeColor
        self.pinUno.clipsToBounds = true
        self.pinUno.layer.cornerRadius = corneRadius
        self.pinUno.font = getFontText()
        self.pinUno.textAlignment = NSTextAlignment.center
        
        self.pinDos.layer.borderWidth = bordeWidt
        self.pinDos.layer.borderColor = bordeColor
        self.pinDos.clipsToBounds = true
        self.pinDos.layer.cornerRadius = corneRadius
        self.pinDos.font = getFontText()
        self.pinDos.textAlignment = NSTextAlignment.center
        
        self.pinTres.layer.borderWidth = bordeWidt
        self.pinTres.layer.borderColor = bordeColor
        self.pinTres.clipsToBounds = true
        self.pinTres.layer.cornerRadius = corneRadius
        self.pinTres.font = getFontText()
        self.pinTres.textAlignment = NSTextAlignment.center
        
        self.pinCuatro.layer.borderWidth = bordeWidt
        self.pinCuatro.layer.borderColor = bordeColor
        self.pinCuatro.clipsToBounds = true
        self.pinCuatro.layer.cornerRadius = corneRadius
        self.pinCuatro.font = getFontText()
        self.pinCuatro.textAlignment = NSTextAlignment.center
        
        self.pinCinco.layer.borderWidth = bordeWidt
        self.pinCinco.layer.borderColor = bordeColor
        self.pinCinco.clipsToBounds = true
        self.pinCinco.layer.cornerRadius = corneRadius
        self.pinCinco.font = getFontText()
        self.pinCinco.textAlignment = NSTextAlignment.center
        
        self.pinSeis.layer.borderWidth = bordeWidt
        self.pinSeis.layer.borderColor = bordeColor
        self.pinSeis.clipsToBounds = true
        self.pinSeis.layer.cornerRadius = corneRadius
        self.pinSeis.font = getFontText()
        self.pinSeis.textAlignment = NSTextAlignment.center
        
        if self.isCustomDelete{
            self.pinUno.keyboardType = .default
            self.pinUno.delegate = self
            self.pinDos.keyboardType = .default
            self.pinDos.delegate = self
            self.pinTres.keyboardType = .default
            self.pinTres.delegate = self
            self.pinCuatro.keyboardType = .default
            self.pinCuatro.delegate = self
            self.pinCinco.keyboardType = .default
            self.pinCinco.delegate = self
            self.pinSeis.keyboardType = .default
            self.pinSeis.delegate = self
            if #available(iOS 12.0, *) {
                self.pinUno.textContentType = .oneTimeCode
                self.pinDos.textContentType = .oneTimeCode
                self.pinTres.textContentType = .oneTimeCode
                self.pinCuatro.textContentType = .oneTimeCode
                self.pinCinco.textContentType = .oneTimeCode
                self.pinSeis.textContentType = .oneTimeCode
            }
        }else{
            self.superTextField.keyboardType = .default
            self.superTextField.delegate = self
            if #available(iOS 12.0, *) {
                self.superTextField.textContentType = .oneTimeCode
            }
        }
    }
    
    @objc func fnIniciarEdicion(_ textField:UITextField){
        newCode = ""
        self.arrayPin.removeAll()
        if textField.text?.count == 0{
            self.pinUno.text = ""
        }else if textField.text?.count == 1{
            self.pinUno.text = self.getTextToPin(textField, typePin: .pinOne)
            self.arrayPin.insert(self.pinUno.text!, at: 0)
        }else if textField.text?.count == 2{
            self.pinUno.text = self.getTextToPin(textField, typePin: .pinOne)
            self.pinDos.text = self.getTextToPin(textField, typePin: .pinTwo)
            self.arrayPin.insert(self.pinUno.text!, at: 0)
            self.arrayPin.insert(self.pinDos.text!, at: 1)
        }else if textField.text?.count == 3{
            self.pinUno.text = self.getTextToPin(textField, typePin: .pinOne)
            self.pinDos.text = self.getTextToPin(textField, typePin: .pinTwo)
            self.pinTres.text = self.getTextToPin(textField, typePin: .pinThree)
            self.arrayPin.insert(self.pinUno.text!, at: 0)
            self.arrayPin.insert(self.pinDos.text!, at: 1)
            self.arrayPin.insert(self.pinTres.text!, at: 2)
        }else if textField.text?.count == 4{
            self.pinUno.text = self.getTextToPin(textField, typePin: .pinOne)
            self.pinDos.text = self.getTextToPin(textField, typePin: .pinTwo)
            self.pinTres.text = self.getTextToPin(textField, typePin: .pinThree)
            self.pinCuatro.text = self.getTextToPin(textField, typePin: .pinFour)
            self.arrayPin.insert(self.pinUno.text!, at: 0)
            self.arrayPin.insert(self.pinDos.text!, at: 1)
            self.arrayPin.insert(self.pinTres.text!, at: 2)
            self.arrayPin.insert(self.pinCuatro.text!, at: 3)
        }else if textField.text?.count == 5{
            self.pinUno.text = self.getTextToPin(textField, typePin: .pinOne)
            self.pinDos.text = self.getTextToPin(textField, typePin: .pinTwo)
            self.pinTres.text = self.getTextToPin(textField, typePin: .pinThree)
            self.pinCuatro.text = self.getTextToPin(textField, typePin: .pinFour)
            self.pinCinco.text = self.getTextToPin(textField, typePin: .pinFive)
            self.arrayPin.insert(self.pinUno.text!, at: 0)
            self.arrayPin.insert(self.pinDos.text!, at: 1)
            self.arrayPin.insert(self.pinTres.text!, at: 2)
            self.arrayPin.insert(self.pinCuatro.text!, at: 3)
            self.arrayPin.insert(self.pinCinco.text!, at: 4)
        }else{
            self.pinUno.text = self.getTextToPin(textField, typePin: .pinOne)
            self.pinDos.text = self.getTextToPin(textField, typePin: .pinTwo)
            self.pinTres.text = self.getTextToPin(textField, typePin: .pinThree)
            self.pinCuatro.text = self.getTextToPin(textField, typePin: .pinFour)
            self.pinCinco.text = self.getTextToPin(textField, typePin: .pinFive)
            self.pinSeis.text = self.getTextToPin(textField, typePin: .pinSix)
            self.arrayPin.insert(self.pinUno.text!, at: 0)
            self.arrayPin.insert(self.pinDos.text!, at: 1)
            self.arrayPin.insert(self.pinTres.text!, at: 2)
            self.arrayPin.insert(self.pinCuatro.text!, at: 3)
            self.arrayPin.insert(self.pinCinco.text!, at: 4)
            self.arrayPin.insert(self.pinSeis.text!, at: 5)
            textField.resignFirstResponder()
            self.pinComplete?(newCode)
        }
    }
    
    func getTextToPin(_ textField:UITextField, typePin : tipoPIN) -> String{
        var lowerBound : String.Index?
        var upperBound : String.Index?
        
        switch typePin {
        case .pinOne:
            lowerBound = String.Index.init(encodedOffset: 0)
            upperBound = String.Index.init(encodedOffset: 1)
            self.pinDos.text = ""
            self.pinTres.text = ""
            self.pinCuatro.text = ""
            self.pinCinco.text = ""
            self.pinSeis.text = ""
        case .pinTwo:
            lowerBound = String.Index.init(encodedOffset: 1)
            upperBound = String.Index.init(encodedOffset: 2)
            self.pinTres.text = ""
            self.pinCuatro.text = ""
            self.pinCinco.text = ""
            self.pinSeis.text = ""
        case .pinThree:
            lowerBound = String.Index.init(encodedOffset: 2)
            upperBound = String.Index.init(encodedOffset: 3)
            self.pinCuatro.text = ""
            self.pinCinco.text = ""
            self.pinSeis.text = ""
        case .pinFour:
            lowerBound = String.Index.init(encodedOffset: 3)
            upperBound = String.Index.init(encodedOffset: 4)
            self.pinCinco.text = ""
            self.pinSeis.text = ""
        case .pinFive:
            lowerBound = String.Index.init(encodedOffset: 4)
            upperBound = String.Index.init(encodedOffset: 5)
            self.pinSeis.text = ""
        default:
            lowerBound = String.Index.init(encodedOffset: 5)
            upperBound = String.Index.init(encodedOffset: 6)
        }
        let newChar: Substring = textField.text![lowerBound!..<upperBound!]
        newCode += String(newChar)
        return String(newChar)
    }
    
    @objc func tapGestureAction(){
        print("Editar Textfield")
        superTextField.becomeFirstResponder()
        self.estadoCampo = 2
    }
    
    @objc func tapGestureView1(){
        print("Edita textfield Uno")
        pinUno.becomeFirstResponder()
        self.estadoCampo = 2
    }
    
    @objc func tapGestureView2(){
        print("Edita textfield Dos")
        pinDos.becomeFirstResponder()
        self.estadoCampo = 2
    }
    @objc func tapGestureView3(){
        print("Edita textfield Tres")
        pinTres.becomeFirstResponder()
        self.estadoCampo = 2
    }
    @objc func tapGestureView4(){
        print("Edita textfield Cuatro")
        pinCuatro.becomeFirstResponder()
        self.estadoCampo = 2
    }
    @objc func tapGestureView5(){
        print("Edita textfield Cinco")
        pinCinco.becomeFirstResponder()
        self.estadoCampo = 2
    }
    @objc func tapGestureView6(){
        print("Edita textfield Seis")
        pinSeis.becomeFirstResponder()
        self.estadoCampo = 2
    }
    
    public func clearViewCode(){
        self.estadoCampo = 2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.arrayPin = ["","","","","",""]
            self.pinSeis.text = ""
            self.pinCinco.text = ""
            self.pinCuatro.text = ""
            self.pinTres.text = ""
            self.pinDos.text = ""
            self.pinUno.text = ""
            if self.isCustomDelete{
                self.newCode = ""
                self.pinUno.becomeFirstResponder()
            }else{
                self.superTextField.text = ""
                self.superTextField.becomeFirstResponder()
            }
        }
    }
    
    
    //MARK: - Funciones GET
    func getFontText() -> UIFont{
        return UIFont(name: FONT_BOGLE_REGULAR, size: 16.0) ?? .systemFont(ofSize: 15)
    }
}


//MARK: - UITextFieldDelegate
extension VMValidateCode : UITextFieldDelegate{
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.letter = textField.text!
//        textField.text = ""
        self.delegateExterno.VMTxtMiBaitDidBeginEditingEx(textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if self.isTextoLargo{
            self.arrayPin = ["","","","","",""]
            var lowerBound : String.Index?
            var upperBound : String.Index?
            for  i in 0..<self.letter.count{
                lowerBound = String.Index.init(encodedOffset: i)
                upperBound = String.Index.init(encodedOffset: i+1)
                let newChar: Substring = self.letter[lowerBound!..<upperBound!]
                let newStr = String(newChar)
                self.arrayPin.remove(at: i)
                self.arrayPin.insert(newStr, at: i)
                
                switch i {
                case 0:
                    self.pinUno.text = newStr
                case 1:
                    self.pinDos.text = newStr
                case 2:
                    self.pinTres.text = newStr
                case 3:
                    self.pinCuatro.text = newStr
                case 4:
                    self.pinCinco.text = newStr
                case 5:
                    self.pinSeis.text = newStr
                default:
                    print("No se agregó caracter \(newStr)")
                }
            }
            if self.letter.count < 6 {
                let faltantes = 6 - self.letter.count
                for i in 0..<faltantes{
                    switch i {
                    case 0:
                        self.pinSeis.text = ""
                    case 1:
                        self.pinCinco.text = ""
                    case 2:
                        self.pinCuatro.text = ""
                    case 3:
                        self.pinTres.text = ""
                    case 4:
                        self.pinDos.text = ""
                    case 5:
                        self.pinUno.text = ""
                    default:
                        print("No se agrega texto vacío para vista de PIN")
                    }
                }
            }
        }else{
            switch textField {
            case self.pinUno:
                self.arrayPin.remove(at: 0)
                self.arrayPin.insert(self.letter, at: 0)
                self.pinUno.text = self.letter
            case self.pinDos:
                self.arrayPin.remove(at: 1)
                self.arrayPin.insert(self.letter, at: 1)
                self.pinDos.text = self.letter
            case self.pinTres:
                self.arrayPin.remove(at: 2)
                self.arrayPin.insert(self.letter, at: 2)
                self.pinTres.text = self.letter
            case self.pinCuatro:
                self.arrayPin.remove(at: 3)
                self.arrayPin.insert(self.letter, at: 3)
                self.pinCuatro.text = self.letter
            case self.pinCinco:
                self.arrayPin.remove(at: 4)
                self.arrayPin.insert(self.letter, at: 4)
                self.pinCinco.text = self.letter
            case self.pinSeis:
                self.arrayPin.remove(at: 5)
                self.arrayPin.insert(self.letter, at: 5)
                self.pinSeis.text = self.letter
            default:
                print("Pin general mapeado")
            }
        }
        
//        print("\n\n:::: ARREGLO PIN ::::")
//        for letra in self.arrayPin{
//            print("\(letra)")
//        }
        self.delegateExterno.VMTxtMiBaitDidEndEditingEx(textField, customDelete: self.isCustomDelete)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("Delegado shouldChangeCharactersIn Framework..")
        let newLength = textField.text!.count + string.count - range.length
        self.delegateExterno.VMTxtMiBaitChangeCharacterEx?(textField, shouldChangeCharactersIn: range, replacementString: string)
        if self.isCustomDelete{
            self.letter = string
            if string.count > 1{
                self.isTextoLargo = true
    //            print("Texto largo: \(string)")
                switch textField {
                case self.pinUno:
                    self.pinUno.resignFirstResponder()
                case self.pinDos:
                    self.pinDos.resignFirstResponder()
                case self.pinTres:
                    self.pinTres.resignFirstResponder()
                case self.pinCuatro:
                    self.pinCuatro.resignFirstResponder()
                case self.pinCinco:
                    self.pinCinco.resignFirstResponder()
                case self.pinSeis:
                    self.pinSeis.resignFirstResponder()
                default:
                    self.pinUno.resignFirstResponder()
                }
                return false
            }else if string != ""{
                self.isTextoLargo = false
                switch textField {
                case self.pinUno:
                    self.pinDos.becomeFirstResponder()
                case self.pinDos:
                    self.pinTres.becomeFirstResponder()
                case self.pinTres:
                    self.pinCuatro.becomeFirstResponder()
                case self.pinCuatro:
                    self.pinCinco.becomeFirstResponder()
                case self.pinCinco:
                    self.pinSeis.becomeFirstResponder()
                case self.pinSeis:
                    self.pinSeis.resignFirstResponder()
                default:
                    print("Pin no mapeado")
                }
                return (newLength >= 1) ? false : true
            }else{
                return (newLength >= 1) ? false : true
            }
        }else{
            if newLength >= 7 {
                textField.resignFirstResponder()
                return false
            }else{
                return true
            }
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("Delegado textFieldShouldReturn Framework..")
//        self.superTextField.resignFirstResponder()
        self.delegateExterno.VMTxtMiBaitShouldReturnEx(textField)
        return true
    }
}

//MARK: - Extensión Metodods Delegado Externo
// Delegado externo para ser utilizado en implementación de textField en caso de necesitar ser notificado de la acción
// NOTA: Las funciones siguientes se ejecutan por Default y no deben llevar ninguna lógica en este framework, solo desde la clase donde se implementan
extension VMValidateCode : VMValidateCodeDelegateExterno{
    public func VMTxtMiBaitDidBeginEditingEx(_ field: UITextField) {
        //
    }
    
    public func VMTxtMiBaitDidEndEditingEx(_ field: UITextField, customDelete: Bool) {
        //print("Delegado Externo DidEndEditingEx..")
    }
    
    public func VMTxtMiBaitChangeCharacterEx(_ field: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        //print("Delegado Externo ChangeCharacterEx..")
    }
    
    public func VMTxtMiBaitShouldReturnEx(_ field: UITextField) {
        //print("Delegado Externo ShouldReturnEx..")
    }
    
    public func VMTxtMiBaitShouldBeginEditingEx(_ field: UITextField) -> Bool {
        //print("Delegado Externo ShouldBeginEditingEx..")
        return true
    }
}


public class MyTextField : UITextField{
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
    
    public override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }
    
    public override func caretRect(for position: UITextPosition) -> CGRect {
        .null
    }
    
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
//            return false
//        }
//        return super.canPerformAction(action, withSender: sender)
//    }
}
#endif
