//
//  VMGenericAlert.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 03/08/23.
//

#if canImport(UIKit)
import UIKit

public enum TypeAlertPage: Int {
    case AlertTypeWarning = 1
    
    /// Obtiene el color del borde, dependiendo del tipo de alert seleccionado
    /// - Returns: - Retorna un UIColor
    func getColorBorder() -> UIColor{
        switch self {
        case .AlertTypeWarning:
            return UIColor.baitColor_alertWarningBORDER()
        }
    }
    
    /// Obtiene el color del background del alert, dependiendo del tipo de alert seleccionado
    /// - Returns: - Retorna un UIColor
    func getColorBackground() -> UIColor{
        switch self {
        case .AlertTypeWarning:
            return UIColor.baitColor_alertWarningBG()
        }
    }
    
    /// Obtiene la fuente del mensaje, dependiendo del tipo de alert seleccionado
    /// - Returns: - Retorna un UIFont
    func getFontDescription() -> UIFont{
        switch self {
        case .AlertTypeWarning:
            return UIFont(name: FONT_BOGLE_REGULAR, size: 12.0) ?? .systemFont(ofSize: 12)
//        default:
//            return UIFont(name: FONT_BOGLE_BLACK, size: 12.0) ?? .systemFont(ofSize: 10)
        }
    }
    
    /// Obtiene e icono , dependiendo del tipo de alert seleccionado
    /// - Returns: - Retorna un UIImage
    func getIcon() -> UIImage{
        switch self {
        case .AlertTypeWarning:
            return UIImage.baitIcon_alertWarning()
        }
    }
}

@IBDesignable public class VMGenericAlert: UIView {
    //outlets
    @IBOutlet var generalViewA: UIView!
    @IBOutlet weak var backGroundViewA: UIView!
    @IBOutlet weak var lateralViewA: UIView!
    @IBOutlet weak var imgIconA: UIImageView!
    @IBOutlet weak var lblDescriptionA: UILabel!
    
    // Variables
    var contentView: UIView!
    var _type : TypeAlertPage!
    var textParams: NSMutableDictionary = NSMutableDictionary()
    
    // Set Up View
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
        self.contentView = loadViewFromNib()
        self.contentView.frame = bounds
        self.contentView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.backgroundColor = .clear
        addSubview(self.contentView)
    }
    
    public func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: VMGenericAlert.self)
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    public override func layoutSubviews() {
        // Rounded corners
        self.layoutIfNeeded()
        self.contentView.layer.masksToBounds = true
//        self.contentView.clipsToBounds = true
//        self.contentView.layer.cornerRadius = 2
//        self.contentView.layer.borderWidth = 2
//        self.contentView.layer.borderColor = UIColor.red.cgColor
    }
    
    public override func didMoveToSuperview() {
        // Fade in when added to superview
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.transform = CGAffineTransform.identity
        })
    }
    
    ///Texto mensaje principal
    @IBInspectable
    public var message: String {
        get {
            return (self.lblDescriptionA?.text)!
        }
        set {
            textParams.setValue(newValue, forKey: "message")
            setFormatForText()
        }
    }
        
    @IBInspectable
    public var typeAlert: Int = 1 {
        didSet {
            guard let enumValue = TypeAlertPage(rawValue: typeAlert) else {
                print("Unsupported type....")
                return
            }
            _type = enumValue
            
            var lateralColor: UIColor?
            var backColor: UIColor?
            var borderColor: UIColor?
            var icon: UIImage?
            
            switch _type.rawValue {
            case TypeAlertPage.AlertTypeWarning.rawValue:
                if #available(iOS 11.0, *) {
                    lateralColor = _type.getColorBorder()
                    backColor = _type.getColorBackground()
                    borderColor = _type.getColorBorder()
                }
                icon = _type.getIcon() //Desde Assets Framework
//                icon = UIImage(named: "Icon-warningP") //Desde Assets Proyecto
            default:
                break
            }
            
            self.lateralViewA.backgroundColor = lateralColor
            self.backGroundViewA.backgroundColor = backColor
            self.imgIconA.image = icon
            
            self.contentView.layer.borderWidth = 1
            self.contentView.layer.borderColor = borderColor?.cgColor
            self.contentView.clipsToBounds = true
            self.contentView.layer.cornerRadius = 4
            self.lblDescriptionA?.font = _type.getFontDescription()
        }
    }
    
    func setFormatForText() {
        var description = ""
        let completeString = NSMutableAttributedString(string: "")
        
        if let desc = textParams["message"] {
            description = desc as! String
            completeString.append(NSAttributedString(string: description))
        }
        
        self.lblDescriptionA.attributedText = completeString
    }
}
#endif
