//
//  Comment.swift
//  HNR
//
//  Created by Tiago Alves on 18/09/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit
import Alamofire

class Comment: NSObject {
    var id:    Int?
    var by:    String?
    var text:  String?
    var time:  NSDate?
    var commentsIds : NSArray = []
    var comments : [Comment] = []
    var indentLevel : Int = 0
    
    convenience init(json: NSDictionary) {
        self.init()
        id    = json.value(forKey: "id")    as? Int
        by    = json.value(forKey: "by")    as? String
        text  = json.value(forKey: "text")  as? String
        
        if let timeString = json.value(forKey: "time") as? Int {
            let date = NSDate(timeIntervalSince1970: TimeInterval(timeString))
            time = date
        }
        if let commentsJSON = json.value(forKey: "kids") as? NSArray {
            commentsIds = commentsJSON
        }
    }
    
    func getComments(completionHandler: @escaping (Bool) -> Void) {
        
        if commentsIds.count > 0 {
            var returnComments : [Comment] = []
            
            let commentsGroup = DispatchGroup()
            for commentId in commentsIds {
                commentsGroup.enter()
                
                let currentIndentLevel = self.indentLevel
                
                Alamofire.request(baseURLString + "item/\(commentId).json").responseJSON { response in
                    if let commentJSON = response.result.value as? NSDictionary {
                        let commentObject = Comment.init(json: commentJSON)
                        commentObject.indentLevel = currentIndentLevel + 1
                        commentObject.getComments(completionHandler: { (success) in
                            returnComments.append(commentObject)
                            commentsGroup.leave()
                        })
                    } else {
                        commentsGroup.leave()
                    }
                }
            }
            
            commentsGroup.notify(queue: .main) {
                self.comments = returnComments
                completionHandler(true)
            }
        } else {
            completionHandler(true)
        }
    }
    
    func numberOfComments() -> Int {
        var numberOfComments = comments.count
        for comment in comments {
            numberOfComments += comment.numberOfComments()
        }
        return numberOfComments
    }
    
    func flattenedComments() -> Any {
        var commentsArray: [Any] = [self]
        for comment in comments {
            commentsArray += comment.flattenedComments() as! Array<Any>
        }
        return commentsArray
    }
}
