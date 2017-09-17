//
//  PaddingTextView.swift
//  HNR
//
//  Created by Tiago Alves on 18/09/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

@IBDesignable
class PaddingTextView: UITextView {
    
    @IBInspectable var insets: CGFloat = 25 {
        didSet {
            textContainerInset = UIEdgeInsets.init(top: insets, left: insets, bottom: insets, right: insets)
        }
    }

}
