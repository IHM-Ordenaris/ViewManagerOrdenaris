// VMGenericErrorAlert.swift

import UIKit

// MARK: - View Delegate
public protocol VMGenericErrorAlertDelegate: AnyObject {
}

@available(iOS 15.0, *)
public class VMGenericErrorAlert: UIViewController, UISheetPresentationControllerDelegate {
    // MARK: - Variable declaration
    public weak var delegate: VMGenericErrorAlertDelegate?
    public override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    // MARK: - View declaration
    private let vContent: UIView = {
        let vContent = UIView(frame: .zero)
        vContent.translatesAutoresizingMaskIntoConstraints = false
        vContent.backgroundColor = .white
        vContent.layer.cornerRadius = 16
        vContent.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return vContent
    }()
    
    private let imageHeader: UIImageView = {
        let imageHeader = UIImageView(frame: .zero)
        imageHeader.translatesAutoresizingMaskIntoConstraints = false
        return imageHeader
    }()
    
    private let lblTitle: UILabel = {
        let lblTitle = UILabel(frame: .zero)
        lblTitle.numberOfLines = 0
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        return lblTitle
    }()

    private let lblSubTitle: UILabel = {
        let lblTitle = UILabel(frame: .zero)
        lblTitle.numberOfLines = 0
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        return lblTitle
    }()
    
    private let btnContinue: VMButtonsMiBait = {
        let btnContinue = VMButtonsMiBait(frame: .zero)
        btnContinue.translatesAutoresizingMaskIntoConstraints = false
        btnContinue.typeButton = 1
        btnContinue.activeButton = true
        btnContinue.isUserInteractionEnabled = true
        return btnContinue
    }()
    
    // MARK: - Override Methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        initUI()
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initializers
    func initUI() {
        initViews()
        initConstraints()
        initListeners()
        initBottomSheetConfig()
    }
    
    // MARK: - Add subviews
    func initBottomSheetConfig() {
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .large
        sheetPresentationController.prefersGrabberVisible = false
        sheetPresentationController.detents = [.large()]
    }
    
    func initViews() {
        view.addSubview(vContent)
        view.addSubview(imageHeader)
        view.addSubview(lblTitle)
        view.addSubview(lblSubTitle)
        view.addSubview(btnContinue)
    }
    
    // MARK: - Add Constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
            vContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            vContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            vContent.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageHeader.topAnchor.constraint(equalTo: vContent.topAnchor, constant: 62),
            imageHeader.heightAnchor.constraint(equalToConstant: 197),
            imageHeader.leadingAnchor.constraint(equalTo: vContent.leadingAnchor, constant: 16),
            imageHeader.trailingAnchor.constraint(equalTo: vContent.trailingAnchor, constant: -16),
            
            lblTitle.topAnchor.constraint(equalTo: imageHeader.bottomAnchor, constant: 32),
            lblTitle.leadingAnchor.constraint(equalTo: vContent.leadingAnchor, constant: 38),
            lblTitle.trailingAnchor.constraint(equalTo: vContent.trailingAnchor, constant: -38),

            lblSubTitle.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 40),
            lblSubTitle.leadingAnchor.constraint(equalTo: vContent.leadingAnchor, constant: 27),
            lblSubTitle.trailingAnchor.constraint(equalTo: vContent.trailingAnchor, constant: -27),

            btnContinue.topAnchor.constraint(equalTo: lblSubTitle.bottomAnchor, constant: 32),
            btnContinue.leadingAnchor.constraint(equalTo: vContent.leadingAnchor, constant: 32),
            btnContinue.trailingAnchor.constraint(equalTo: vContent.trailingAnchor, constant: -32),
            btnContinue.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Add Listeners
    func initListeners() {
        btnContinue.addTarget(nil, action: #selector(pressContinue), for: .touchUpInside)
    }
    
    // MARK: - Functions
    public func setImageHeader(_ imgName: String) {
        imageHeader.image = UIImage(named: imgName)
    }
    
    public func setConfigTitle(_ title: String, _ font: String, _ size: Double, _ alignment: NSTextAlignment) {
        lblTitle.text = title
        lblTitle.font = UIFont(name: font, size: CGFloat(size))
        lblTitle.textAlignment = alignment
    }
    
    public func setConfigSubTitle(_ title: String, _ font: String, _ size: Double, _ alignment: NSTextAlignment) {
        lblSubTitle.text = title
        lblSubTitle.font = UIFont(name: font, size: CGFloat(size))
        lblSubTitle.textAlignment = alignment
    }
    
    public func setConfigButton(_ isActive: Bool, _ title: String) {
        btnContinue.activeButton = isActive
        btnContinue.setTitle(title, for: .normal)
        btnContinue.layer.cornerRadius = 20
    }
    
    @objc func pressContinue() {
        print("Dismiss View Error...")
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extensions
@available(iOS 15.0, *)
extension VMGenericErrorAlert: UISheetPresentationControllerDelegate {
    public func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return false // Disable dismissal
    }
}
