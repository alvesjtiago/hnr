//
//  Comment.swift
//  HNR
//
//  Created by Tiago Alves on 18/09/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

class Comment: NSObject {
    var id:    Int?
    var by:    String?
    var text:  String?
    var time:  NSDate?
    
    convenience init(json: NSDictionary) {
        self.init()
        id    = json.value(forKey: "id")    as? Int
        by    = json.value(forKey: "by")    as? String
        text  = json.value(forKey: "text")  as? String
        
        if let timeString = json.value(forKey: "time") as? Int {
            let date = NSDate(timeIntervalSince1970: TimeInterval(timeString))
            time = date
        }
    }
}
