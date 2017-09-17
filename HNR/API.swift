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
                let numberOfNews = topstoriesJSON.count > size ? size : topstoriesJSON.count
                topstoriesJSON = topstoriesJSON.subarray(with: NSRange(location: 0, length: numberOfNews)) as NSArray
                
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
    
    // Fetch top jobs
    public func fetchJobs(size: Int, completionHandler: @escaping (Bool, [Job]) -> Void) {
        
        Alamofire.request(baseURLString + "jobstories.json").responseJSON { response in
            if var topJobsJSON = response.result.value as? NSArray {
                let numberOfJobs = topJobsJSON.count > size ? size : topJobsJSON.count
                topJobsJSON = topJobsJSON.subarray(with: NSRange(location: 0, length: numberOfJobs)) as NSArray
                
                var returnJobs : [Job] = []
                
                let jobsGroup = DispatchGroup()
                for (_, job) in topJobsJSON.enumerated() {
                    jobsGroup.enter()
                    
                    Alamofire.request(baseURLString + "item/\(job).json").responseJSON { response in
                        if let jobJSON = response.result.value as? NSDictionary {
                            let jobObject = Job.init(json: jobJSON)
                            returnJobs.append(jobObject)
                        }
                        jobsGroup.leave()
                    }
                }
                
                jobsGroup.notify(queue: .main) {
                    returnJobs.sort {a, b in
                        topJobsJSON.index(of: a.id!) < topJobsJSON.index(of: b.id!)
                    }
                    
                    completionHandler(true, returnJobs)
                }
                
            } else {
                completionHandler(false, [])
            }
        }
    }
}
