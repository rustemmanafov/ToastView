//
//  ToastView.swift
//  ToastView
//
//  Created by Rustam Manafli on 15.06.23.
//


import UIKit

class ToastView: UIView {

    let viewModel: ToastModel
    
    private var handler: Handler?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.11, green: 0.13, blue: 0.31, alpha: 1.00)
        label.numberOfLines = 0
        label.textAlignment = .center
        //label.font = UIFont(name: "Roboto-Regular", size: 15)
        label.font = label.font.withSize(15)

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
        
        backgroundColor = UIColor(red: 0.00, green: 0.69, blue: 0.31, alpha: 0.06)
        
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0, green: 0.69, blue: 0.306, alpha: 1).cgColor
        configure()
    }
    
    private func configure() {
        label.text = viewModel.text
        imageView.image = viewModel.image
        
        switch viewModel.type {
        case .action(let handler):
            self.handler = handler
            
            isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapToast))
            gesture.numberOfTouchesRequired = 1
            gesture.numberOfTapsRequired = 1
            addGestureRecognizer(gesture)
            
        case .info:
            break
        case .success:
            break
        case .error:
            break
        }
    }
    
    @objc func didTapToast() {
        handler?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if viewModel.image != nil {
            imageView.frame = CGRect(x: 15, y: 5, width: 24, height: 24)
            imageView.center.y = frame.height / 2

            label.frame = CGRect(x: imageView.frame.origin.x + 20, y: 0, width: frame.width - imageView.frame.maxX - 5, height: frame.height)
            label.center.y = frame.height / 2
        } else {
            label.frame = bounds

        }
         
    }
    
    
}
