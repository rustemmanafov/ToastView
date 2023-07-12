//
//  ViewController.swift
//  ToastView
//
//  Created by Rustam Manafli on 15.06.23.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func buttonAct(_ sender: Any) {
        
        ToastUtility.showToast(type: .success, onView: self.view) {
            print("Toast tapped")
        }
    }
    
    @IBAction func errorBtn(_ sender: Any) {
        
        ToastUtility.showToast(type: .error, onView: self.view) {
            print("Toast tapped")
        }
    }
    
    
}

