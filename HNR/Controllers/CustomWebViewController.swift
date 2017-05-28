//
//  CustomWebViewController.swift
//  HNR
//
//  Created by Tiago Alves on 25/05/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit
import SafariServices

class CustomWebViewController: SFSafariViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change color
        preferredBarTintColor = UIColor(red:0.17, green:0.19, blue:0.27, alpha:1.00)
    }
    
}
