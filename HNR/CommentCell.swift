//
//  CommentCell.swift
//  HNR
//
//  Created by Tiago Alves on 18/09/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    var comment: Comment?
    @IBOutlet weak var authorLabel:  UILabel!
    @IBOutlet weak var timeLabel:    UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    
    var defaultAuthorLabelLeadingConstant = 9
    @IBOutlet weak var authorLabelLeadingConstraint: NSLayoutConstraint!
    var defaultTimeLabelLeadingConstant = 9
    @IBOutlet weak var timeLabelLeadingConstraint: NSLayoutConstraint!
    var defaultContentLabelLeadingConstant = 9
    @IBOutlet weak var contentLabelLeadingConstraint: NSLayoutConstraint!
    
    func set(comment: Comment) {
        self.comment = comment
        
        let dateFormatter = DateFormatter()
        let timeString = dateFormatter.timeSince(from: comment.time!, numericDates: true)
        
        timeLabel.text = timeString
        if let author = comment.by {
            authorLabel.text  = author
        }
        if let content = comment.text {
            contentLabel.setHTMLFromString(text: content)
        }
    }

}

extension UITextView {
    func setHTMLFromString(text: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: AvenirNext-Regular; font-size: 14.0\">%@</span>" as NSString, text)
        
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        
        self.attributedText = attrStr
    }
}
