//
//  RoundLabel.swift
//  HNR
//
//  Created by Tiago Alves on 21/05/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

@IBDesignable
class RoundLabel: UILabel {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Make it round
        layer.masksToBounds = true
        layer.cornerRadius = rect.size.height / 2
        layer.borderColor = UIColor.init(red: 253.0/255.0, green: 109.0/255.0, blue: 78.0/255.0, alpha: 1.0).cgColor
        layer.borderWidth = 1.0
    }

}
