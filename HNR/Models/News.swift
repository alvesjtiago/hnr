//
//  News.swift
//  HNR
//
//  Created by Tiago Alves on 21/05/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

class News: NSObject {
    var title: String?
    var score: Int?
    var by:    String?
    var url:   URL?
    
    convenience init(json: NSDictionary) {
        self.init()
        title = json.value(forKey: "title") as? String
        score = json.value(forKey: "score") as? Int
        by    = json.value(forKey: "by")    as? String
        if let urlString = json.value(forKey: "url") as? String {
            url   = URL(string: urlString)
        }
    }
}
