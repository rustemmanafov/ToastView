//
//  ToastModel.swift
//  ToastView
//
//  Created by Rustam Manafli on 15.06.23.
//

import UIKit

typealias Handler = (() -> Void)

enum ToastViewType {
    case info
    case success
    case error
    case action(handler: Handler)
}

struct ToastModel {
    let type: ToastViewType
    let text: String
    let image: UIImage?
}
