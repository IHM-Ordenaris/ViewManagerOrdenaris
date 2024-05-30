//
//  VMTextFieldBait.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 04/08/23.
//

#if canImport(UIKit)
import UIKit


//MARK: Protocol VMTextFieldsDelegate Externo
@objc public protocol VMTextFieldsDelegateExterno{
    @objc func VMTxtMiBaitDidBeginEditingEx(_ field: VMTextFields)
    @objc func VMTxtMiBaitDidEndEditingEx(_ field: VMTextFields)
    @objc optional func VMTxtMiBaitChangeCharacterEx(_ field: VMTextFields, shouldChangeCharactersIn range: NSRange, replacementString string: String)
    @objc func VMTxtMiBaitShouldReturnEx(_ field: VMTextFields)
    @objc optional func VMTxtMiBaitShouldBeginEditingEx(_ field: VMTextFields) -> Bool
}

//MARK: Public CLASS VMTextFields
@IBDesignable
public class VMTextFieldBait: UIView, VMTextFieldsDelegate {
    
    @objc public var delegateExterno: VMTextFieldsDelegateExterno!
    @objc public var useTableViewBackgroundColor: Bool = false {
        didSet {
            self.txtFieldBait.useTableViewBackgroundColor = self.useTableViewBackgroundColor
        }
    }
    
    //MARK: - Variables
    static var stateFieldStatic = 0
    
    //MARK: - IBOutlets
    @IBOutlet var viewBGB: UIView!
    @IBOutlet public weak var lblTituloB: UILabel!
    @IBOutlet public weak var txtFieldBait: VMTextFields!
    @IBOutlet public weak var lblSoporteB: UILabel!
    @IBOutlet public weak var imageSoporteB: UIImageView!
    
    
    var auxPlaceholder = ""
    //MARK: - Funciones inicio
    
    func xibSetup() {
        self.delegateExterno = self
        self.viewBGB = loadViewFromNib()
        self.viewBGB.frame = bounds
        self.viewBGB.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.viewBGB.layoutIfNeeded()
        self.layoutIfNeeded()
        addSubview(self.viewBGB)
        self.viewBGB.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.lblTituloB.backgroundColor = UIColor.baitColor_TextFieldBG()
        self.lblTituloB.isHidden = true
        txtFieldBait.delegateCustom = self
        self.lblSoporteB.text = ""
        self.lblTituloB.text = ""
    }
    
    public func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: VMTextFieldBait.self)
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    public override func layoutSubviews() {
        self.layoutIfNeeded()
    }
    
    //MARK: - IBinspectables
    @IBInspectable public var tipoCampo: Int = 1 {
        didSet{
            guard let enumValue = EnumTypeTxtBait(rawValue: tipoCampo) else{
                print("Tipo Text field no soportado....")
                return
            }
            self.txtFieldBait.typeField = enumValue.rawValue
            self.lblSoporteB.text = enumValue.getTextoSoporteInformativo()
        }
    }
    
    @IBInspectable public var estadoCampo: Int = 1 {
        didSet{
            guard let enumValue = EnumStateTxtBait(rawValue: estadoCampo) else {
                print("Estado TextField no soportado....")
                return
            }
            VMTextFieldBait.stateFieldStatic = estadoCampo
            if estadoCampo == EnumStateTxtBait.error.rawValue{
                self.imageSoporteB.isHidden = false
            }else{
                self.lblSoporteB.text = " "
                self.imageSoporteB.isHidden = true
            }
            
            self.txtFieldBait.stateField = enumValue.rawValue
            self.lblTituloB.textColor = enumValue.getColorTextoTitle()!
            self.lblSoporteB.textColor = enumValue.getColorTextoSoporte()!
            
            if ((self.txtFieldBait.text != "") && (self.txtFieldBait.stateField == EnumStateTxtBait.activo.rawValue ||
                                        self.txtFieldBait.stateField == EnumStateTxtBait.error.rawValue ||
                                        self.txtFieldBait.stateField == EnumStateTxtBait.success.rawValue ||
                                        self.txtFieldBait.stateField == EnumStateTxtBait.focalizado.rawValue)){
                self.lblTituloB.isHidden = false
            }else{
                if(self.txtFieldBait.stateField == EnumStateTxtBait.error.rawValue || self.txtFieldBait.stateField == EnumStateTxtBait.editing.rawValue){
                    self.lblTituloB.isHidden = false
                }else{
                    self.lblTituloB.isHidden = true
                }
            }
        }
    }
    
    @IBInspectable public var placeHolderCampo: String = "" {
        didSet{
            var attribute = NSAttributedString(string: placeHolderCampo, attributes: [NSAttributedString.Key.foregroundColor: UIColor.baitColor_TextFieldPlaceholderDeshabilitado()])
            if self.txtFieldBait.stateField != EnumStateTxtBait.deshabilitado.rawValue{
                attribute = NSAttributedString(string: placeHolderCampo, attributes: [NSAttributedString.Key.foregroundColor: UIColor.baitColor_TextFieldPlaceholder()])
            }
           
            self.txtFieldBait.attributedPlaceholder = attribute
        }
    }
    
    @IBInspectable public var textTitulo: String = "" {
        didSet{
            if textTitulo != ""{
                let title = "  \(textTitulo)  "
                self.lblTituloB.text = title
            }
        }
    }
    
    @IBInspectable public var textSoporte: String = "" {
        didSet{
            self.lblSoporteB.text = ""
            if textSoporte != ""{
                self.lblSoporteB.text = textSoporte
            }
        }
    }
    
    //MARK: - VMTextFieldsDelegate
    public func VMTxtMiTelcelDidEndEditing(_ field: VMTextFields) {
        print("Delegado DidEndEditing...")
        guard let enumValue = EnumStateTxtBait(rawValue: field.stateField) else {
            print("Estado TextField no soportado en delegado DidEndEditing....")
            return
        }
        self.lblTituloB.textColor = enumValue.getColorTextoTitle()!
        self.lblSoporteB.textColor = enumValue.getColorTextoSoporte()!
        if ((field.text != "") && (field.stateField == EnumStateTxtBait.activo.rawValue ||
                                    field.stateField == EnumStateTxtBait.error.rawValue ||
                                    field.stateField == EnumStateTxtBait.success.rawValue)){
            self.lblTituloB.isHidden = false
        }else{
            if (field.text == ""){
                self.estadoCampo = EnumStateTxtBait.inactivo.rawValue
            }
            self.lblTituloB.isHidden = true
        }
        delegateExterno.VMTxtMiBaitDidEndEditingEx(field)
        self.placeHolderCampo = auxPlaceholder
    }
    
    public func VMTxtMiTelcelDidBeginEditing(_ field: VMTextFields) {
        print("Delegado DidBeginEditing....")
        guard let enumValue = EnumStateTxtBait(rawValue: field.stateField) else {
            print("Estado TextField no soportado en delegado DidBeginEditing....")
            return
        }
        self.lblTituloB.textColor = enumValue.getColorTextoTitle()!
        self.lblSoporteB.textColor = UIColor.baitColor_TextFieldActivoTextoSecundario()
        self.lblTituloB.isHidden = false
        auxPlaceholder = self.placeHolderCampo
        self.placeHolderCampo = ""
        delegateExterno.VMTxtMiBaitDidBeginEditingEx(field)
    }
    
    public func VMTxtMiTelcelChangeCharacter(_ field: VMTextFields, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        print("Delegado ChangeCharacter...")
        delegateExterno.VMTxtMiBaitChangeCharacterEx!(field, shouldChangeCharactersIn: range, replacementString: string)
    }
    
    
    
    /// Delegados Métodos Secundarios
    public func VMTxtMiTelcelShouldReturn(_ field: VMTextFields) {
        //
        delegateExterno.VMTxtMiBaitShouldReturnEx(field)
    }
    
    public func VMTxtMiTelcelShouldBeginEditing(_ field: VMTextFields) -> Bool {
        //
        return true
    }
}


//MARK: - Extensión Metodods Delegado Externo
// Delegado externo para ser utilizado en implementación de textField en caso de necesitar ser notificado de la acción
// NOTA: Las funciones siguientes se ejecutan por Default y no deben llevar ninguna lógica en este framework, solo desde la clase donde se implementan
extension VMTextFieldBait : VMTextFieldsDelegateExterno{
    public func VMTxtMiBaitDidBeginEditingEx(_ field: VMTextFields) {
        //
    }
    
    public func VMTxtMiBaitDidEndEditingEx(_ field: VMTextFields) {
        //print("Delegado Externo DidEndEditingEx..")
    }
    
    public func VMTxtMiBaitChangeCharacterEx(_ field: VMTextFields, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        //print("Delegado Externo ChangeCharacterEx..")
    }
    
    public func VMTxtMiBaitShouldReturnEx(_ field: VMTextFields) {
        //print("Delegado Externo ShouldReturnEx..")
    }
    
    public func VMTxtMiBaitShouldBeginEditingEx(_ field: VMTextFields) -> Bool {
        //print("Delegado Externo ShouldBeginEditingEx..")
        return true
    }
}
#endif
