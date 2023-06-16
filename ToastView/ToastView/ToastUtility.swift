//
//  ToastUtility.swift
//  ToastView
//
//  Created by Rustam Manafli on 15.06.23.
//

import UIKit

class ToastUtility {
    static func showToast(toast: ToastView, onView view: UIView) {
        let width = view.frame.size.width / 1.3
        toast.frame = CGRect(x: (view.frame.size.width - width) / 2, y: view.frame.size.height, width: width, height: 60)

        view.addSubview(toast)

        UIView.animate(withDuration: 0.5, animations: {
            toast.frame = CGRect(x: (view.frame.size.width - width) / 2, y: view.frame.size.height - 98, width: width, height: 78)
        }) { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        toast.frame = CGRect(x: (view.frame.size.width - width) / 2, y: view.frame.size.height, width: width, height: 78)
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

