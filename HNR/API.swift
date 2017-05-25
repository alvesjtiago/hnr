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
    
    public func fetchNews(size: Int, completionHandler: @escaping (Bool, Array<News>) -> Void) {
        let allNewNews : NSMutableArray = []
        
        Alamofire.request(baseURLString + "topstories.json").responseJSON { response in
            if response.result.value != nil {
                
                var arrayOfNews = response.result.value as! NSArray
                arrayOfNews = arrayOfNews.subarray(with: NSRange(location: 0, length: size)) as NSArray
                
                for _ in arrayOfNews {
                    allNewNews.add(NSNull.init())
                }
                
                let newsGroup = DispatchGroup()
                
                for (index, news) in arrayOfNews.enumerated() {
                    newsGroup.enter()
                    
                    Alamofire.request(baseURLString + "item/\(news).json").responseJSON { response in
                        if let JSON = response.result.value {
                            let newsObject = News.init(json: (JSON as? NSDictionary)!)
                            allNewNews.replaceObject(at: index, with: newsObject)
                        }
                        newsGroup.leave()
                    }
                }
                
                newsGroup.notify(queue: .main) {
                    completionHandler(true, allNewNews as! Array<News>)
                }
                
            } else {
                completionHandler(false, [])
            }
        }
    }
}
