//
//  TipCalculatorViewController.swift
//  Tipsy
//


import UIKit

class TipCalculatorViewController: UIViewController {

    @IBOutlet weak var taxField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var zeroPercentButton: UIButton!
    @IBOutlet weak var tenPercentButton: UIButton!
    @IBOutlet weak var twentyPercentButon: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBOutlet weak var personStepper: UIStepper!
    
    private var buttonList : [UIButton: Float] = [:]
    
    private var isKeyboardShow : Bool = false
 
    var billEngine : BillEngineInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billEngine = billEngine ?? BillEngine(billInfo: BillInfo(), split: 2)
        let tab = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tab)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name:  UIResponder.keyboardDidShowNotification ,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        billEngine?.taxPercent = BillEngine.defaultTax
  
        taxField.text = billEngine?.taxDisplay
        
        buttonList = [zeroPercentButton : 0.0, tenPercentButton : 0.10, twentyPercentButon : 0.20]
        setButtonSelected(selectedButton: zeroPercentButton)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification ,object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    fileprivate func setButtonSelected(selectedButton : UIButton) {
        buttonList.keys.forEach { (button) in
            button.isSelected = selectedButton == button
        }
    }
    
    @objc func handleKeyboardShow(_ notification: NSNotification) {
        switch notification.name {
        case UIResponder.keyboardDidHideNotification :
            isKeyboardShow = false
        case UIResponder.keyboardDidShowNotification :
            isKeyboardShow = true
        default:
            print("Other keyboard state: \(notification.name)")
        }
    }
    fileprivate func handleKeyboardDisplay() {
        if isKeyboardShow {
            view.endEditing(true)
        }
    }
    
    @IBAction func tipButtonPress(_ sender: UIButton) {
        handleKeyboardDisplay()
        billEngine?.tipsPercent = buttonList[sender] ?? 0.0
        setButtonSelected(selectedButton: sender)
    }
    
    @IBAction func personStepperValueChanged(_ sender: UIStepper) {
        handleKeyboardDisplay()
        billEngine?.splitNumber = Int(sender.value)
        splitNumberLabel.text = billEngine?.splitDisplay
    }
    
    @IBAction func amountFieldEditEnded(_ sender: UITextField) {
        guard let str = amountField.text else {
            print("Error: no amount entered")
            return
        }
        billEngine?.amountPreTax = (str as NSString).floatValue

    }
    @IBAction func taxFieldEditEnded(_ sender: UITextField) {
        guard let str = taxField.text else {
            print("Error: no tax entered")
            return
        }
        billEngine?.taxPercent = (str as NSString).floatValue
    }
    
    @IBAction func calculateButtonPress(_ sender: Any) {
        handleKeyboardDisplay()
        do {
            let resultView : ResultViewController = try self.instantiateViewController(ResultViewController.self)
            guard let engine = billEngine else {
                throw NSError.init(domain: "TipCalculateViewController.calculateButtonPress", code: 201, userInfo: ["billEngine": "is null"])
            }
            resultView.initilize(engine)
            resultView.presentingViewController?.modalPresentationStyle = .popover
            self.present(resultView, animated: true)
        } catch let error {
            print("Error instantiated result viewController \(error)")
        }
    }
    
    
}

