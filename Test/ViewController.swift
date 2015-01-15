//
//  ViewController.swift
//  Test
//
//  Created by Yongbo on 1/13/15.
//  Copyright (c) 2015 Yongbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var testBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //textField.keyboardType = UIKeyboardType.NumberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func test(sender: AnyObject) {
        var alert = UIAlertController(title:"Alert", message:"Message", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter text:"
            //textField.secureTextEntry = true
            textField.keyboardType = UIKeyboardType.WebSearch
        })
        self.presentViewController(alert, animated: true, completion: nil)
        var list1 = OrderList.sharedInstance
        var list2 = OrderList.sharedInstance
        println(list1 === list2)
        println(list2)
        
        
        //UIApplication.sharedApplication().openURL(NSURL(string: "tel://5175991392")!)
    }
}

