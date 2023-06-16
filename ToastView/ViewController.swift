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
        let viewModel = ToastModel(type: .info, text: "Your PIN changed Successfully!", image: UIImage(named: "tick"))
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width / 1.3, height: 78)
        let toast = ToastView(viewModel: viewModel, frame: frame)
        ToastUtility.showToast(toast: toast, onView: view)
    }
    
    
    func showToast(toast: ToastView) {
        let width = view.frame.size.width/1.3
        toast.frame = CGRect(x: (view.frame.size.width - width)/2, y: view.frame.size.height, width: width, height: 60)
        
        view.addSubview(toast)
        
        UIView.animate(withDuration: 0.3, animations: {
            toast.frame = CGRect(x: (self.view.frame.size.width - width)/2, y: self.view.frame.size.height - 98, width: width, height: 78)
        }) { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    UIView.animate(withDuration: 0.3, animations: {
                        toast.frame = CGRect(x: (self.view.frame.size.width - width)/2, y: self.view.frame.size.height, width: width, height: 78)
                    }) { finished in
                        if finished {
                            toast.removeFromSuperview()
                        }
                    }
                })
            }
        }
    }
    
}

