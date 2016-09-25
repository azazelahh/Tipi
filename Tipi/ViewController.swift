//
//  ViewController.swift
//  Tipi
//
//  Created by Olya Sorokina on 9/24/16.
//  Copyright © 2016 Olya Sorokina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "lastBill")
        defaults.synchronize()
        
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultPercentIndex = defaults.integerForKey("defaultPercentIndex")
        
        tipControl.selectedSegmentIndex = defaultPercentIndex
        let lastBill = defaults.objectForKey("lastBill") as! String
        
        if(lastBill.isEmpty)
        {
            billField.text = lastBill
        }
        
        calculateTip(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        
        let tipPercents = [ 0.18, 0.20, 0.25 ]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercents[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String.init(format: "$%.2f", tip)
        totalLabel.text = String.init(format: "$%.2f", total)
    }
}

