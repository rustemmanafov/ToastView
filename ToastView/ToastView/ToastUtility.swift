//
//  ToastUtility.swift
//  ToastView
//
//  Created by Rustam Manafli on 15.06.23.
//

import UIKit

enum ToastViewType {
    case info
    case success
    case error
}

struct ToastModel {
    let type: ToastViewType
    let text: String
    let image: UIImage?
}

class ToastView: UIView {

    let viewModel: ToastModel
    
    var actionCallback: (() -> Void)?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.11, green: 0.13, blue: 0.31, alpha: 1.00)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Regular", size: 15)

        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    init(viewModel: ToastModel, frame: CGRect) {
        
        self.viewModel = viewModel
        super.init(frame: frame)
        
        addSubview(label)
        
        if viewModel.image != nil {
            addSubview(imageView)
        }
        
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        configure()
    }
    
    private func configure() {
        
        label.text = viewModel.text
        imageView.image = viewModel.image
        
        switch viewModel.type {
        case .success:
            self.actionCallback?()
            backgroundColor = UIColor(red: 0.00, green: 0.69, blue: 0.31, alpha: 0.06)
            layer.borderColor = UIColor(red: 0, green: 0.69, blue: 0.306, alpha: 1).cgColor
        case .info:
            self.actionCallback?()
        case .error:
            self.actionCallback?()
            backgroundColor = .red
            layer.borderColor = UIColor(red: 1.00, green: 0.86, blue: 0.88, alpha: 1.00).cgColor
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
        
        self.actionCallback?()
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        self.actionCallback?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if viewModel.image != nil {
            imageView.frame = CGRect(x: 15, y: 5, width: 24, height: 24)
            imageView.center.y = frame.height / 2

            label.frame = CGRect(x: imageView.frame.origin.x + 20, y: 0, width: frame.width - imageView.frame.maxX, height: frame.height)
            label.center.y = frame.height / 2
        } else {
            label.frame = bounds
        }
    }
}

class ToastUtility {
    
  static var isToastShowing = false
    
    static func showToast(type: ToastViewType, onView view: UIView, actionCallback: (() -> Void)? = nil) {
            let text: String
            let image: UIImage?
            
            switch type {
            case .info:
                text = "Info"
                image = nil
            case .success:
                text = "Success"
                image = UIImage(named: "toast_success")
            case .error:
                text = "Error"
                image = UIImage(named: "toast_error")
            }
            
            let viewModel = ToastModel(type: type, text: text, image: image)
            let frame = CGRect(x: 0, y: 0, width: view.frame.size.width / 1.3, height: 78)
            let toast = ToastView(viewModel: viewModel, frame: frame)
            ToastUtility.showToast(toast: toast, onView: view)
        
            toast.actionCallback = actionCallback
        }
    
    static func showToast(toast: ToastView, onView view: UIView) {
        if isToastShowing {
            return
        }
        
        isToastShowing = true
        
        let width = view.frame.size.width / 1.3
        toast.frame = CGRect(x: (view.frame.size.width - width) / 2, y: view.frame.size.height, width: width, height: 60)
        
        view.addSubview(toast)
        
        UIView.animate(withDuration: 0.5, animations: {
            toast.frame = CGRect(x: (view.frame.size.width - width) / 2, y: view.frame.size.height - 98, width: width, height: 78)
        }) { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        toast.frame = CGRect(x: (view.frame.size.width - width) / 2, y: view.frame.size.height, width: width, height: 78)
                    }) { finished in
                        if finished {
                            toast.removeFromSuperview()
                            isToastShowing = false
                            
                        }
                    }
                })
            }
        }
    }
}
