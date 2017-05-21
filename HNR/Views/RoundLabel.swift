//
//  RoundLabel.swift
//  HNR
//
//  Created by Tiago Alves on 21/05/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

class RoundLabel: UILabel {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Make it round
        self.layer.masksToBounds = true
        self.layer.cornerRadius = rect.size.height / 2
    }

}
