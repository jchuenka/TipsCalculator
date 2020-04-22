//
//  TipCalculatorControllerView.swift
//  Tipsy
//


import UIKit

class TipCalculatorControllerView: UIViewController {

    @IBOutlet weak var taxField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var zeroPercentButton: UIButton!
    @IBOutlet weak var tenPercentButton: UIButton!
    @IBOutlet weak var twentyPercentButon: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBOutlet weak var personStepper: UIStepper!
    
    private var isKeyboardShow : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tab = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tab)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name:  UIResponder.keyboardDidShowNotification ,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification ,object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
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
    }
    
    @IBAction func personStepperValueChanged(_ sender: UIStepper) {
        handleKeyboardDisplay()
    }
    
    @IBAction func calculateButtonPress(_ sender: Any) {
        handleKeyboardDisplay()
    }
    
    
}

