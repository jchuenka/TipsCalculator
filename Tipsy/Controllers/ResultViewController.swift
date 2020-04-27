//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Ubonvan Chuenkamon on 4/21/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var splitDescLable: UILabel!
    private var engine : BillEngineInterface?
    
    func initilize(_ engine : BillEngineInterface) {
        self.engine = engine
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = engine?.splitAmountDisplay ?? "0.0"
        guard let splitNum = engine?.splitNumber,
            let tipDisplay = engine?.tipDisplay,
            let totalDisplay = engine?.totalAmountDisplay else {
            print("Error: No engine value provided")
            splitDescLable.text = "Error, no value provided!"
            splitDescLable.textColor = .red
            return
        }
        totalLabel.text = "Total: \(totalDisplay)"
        splitDescLable.text = "Split between \(splitNum) people with \(tipDisplay) tip"
        
    }
    

    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
