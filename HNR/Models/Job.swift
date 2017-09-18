//
//  Job.swift
//  HNR
//
//  Created by Tiago Alves on 17/09/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

class Job: NSObject {
    var id:    Int?
    var title: String?
    var text:  String?
    var score: Int?
    var by:    String?
    var url:   URL?
    
    convenience init(json: NSDictionary) {
        self.init()
        id    = json.value(forKey: "id")    as? Int
        title = json.value(forKey: "title") as? String
        text  = json.value(forKey: "text") as? String
        score = json.value(forKey: "score") as? Int
        by    = json.value(forKey: "by")    as? String
        if let urlString = json.value(forKey: "url") as? String {
            url = URL(string: urlString)
        }
    }
}
