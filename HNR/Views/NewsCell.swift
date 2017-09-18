//
//  NewsCell.swift
//  HNR
//
//  Created by Tiago Alves on 19/05/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    var news: News?
    @IBOutlet weak var titleLabel:  UILabel?
    @IBOutlet weak var countLabel:  RoundLabel?
    @IBOutlet weak var authorLabel: UILabel?
    @IBOutlet weak var commentsButton: CommentsButton?
    
    func set(news: News) {
        self.news = news
        
        titleLabel?.text = news.title!
        countLabel?.text = String(describing: news.score!)
        commentsButton?.setTitle(String(describing: news.numberOfComments!), for: .normal)
        
        if news.by != nil {
            let author = news.by!
            let attrs = [NSFontAttributeName : UIFont(name: "AvenirNext-Bold", size: 14)!]
            let boldString = NSAttributedString(string: author, attributes: attrs)
            
            let attributedString = NSMutableAttributedString(string:"by ")
            attributedString.append(boldString)
            
            authorLabel?.attributedText = attributedString
        }
    }

}
