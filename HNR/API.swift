//
//  API.swift
//  HNR
//
//  Created by Tiago Alves on 22/05/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit
import Alamofire

let baseURLString = "https://hacker-news.firebaseio.com/v0/"

class API: NSObject {
    
    // Singleton creation
    static let sharedInstance = API()
    private override init() {} // Prevents outside calling of init
    
    // Fetch top stories
    public func fetchNews(size: Int, completionHandler: @escaping (Bool, [News]) -> Void) {
        
        Alamofire.request(baseURLString + "topstories.json").responseJSON { response in
            if var topstoriesJSON = response.result.value as? NSArray {
                topstoriesJSON = topstoriesJSON.subarray(with: NSRange(location: 0, length: size)) as NSArray
                
                var returnNews : [News] = []
                
                let newsGroup = DispatchGroup()
                for (_, news) in topstoriesJSON.enumerated() {
                    newsGroup.enter()
                    
                    Alamofire.request(baseURLString + "item/\(news).json").responseJSON { response in
                        if let newsJSON = response.result.value as? NSDictionary {
                            let newsObject = News.init(json: newsJSON)
                            returnNews.append(newsObject)
                        }
                        newsGroup.leave()
                    }
                }
                
                newsGroup.notify(queue: .main) {
                    returnNews.sort {a, b in
                        topstoriesJSON.index(of: a.id!) < topstoriesJSON.index(of: b.id!)
                    }
                    
                    completionHandler(true, returnNews)
                }
                
            } else {
                completionHandler(false, [])
            }
        }
    }
}
