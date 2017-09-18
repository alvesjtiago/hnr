//
//  CommentsTableViewController.swift
//  HNR
//
//  Created by Tiago Alves on 18/09/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {
    
    var commentsIds : NSArray = []
    var allComments : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set automatic height calculation for cells
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85.0
        
        // Trigger refresh news when pull to refres is triggered
        refreshControl?.addTarget(self, action: #selector(refreshComments), for: UIControlEvents.valueChanged)
        
        // Start refresh when view is loaded
        tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentOffset.y - 30), animated: false)
        tableView.refreshControl?.beginRefreshing()
        refreshComments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allComments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        
        let comment = allComments[indexPath.row] as! Comment
        cell.set(comment: comment)
        
        return cell
    }
    
    func refreshComments() {
        API.sharedInstance.fetchComments(commentsIds: commentsIds as! [Int]) { (success, comments) in
            
            // Update array of news and interface
            self.allComments = comments as! NSMutableArray
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            
            if (!success) {
                // Display error
                let alertView: UIAlertController = UIAlertController.init(title: "Error fetching news",
                                                                          message: "There was an error fetching the new Hacker News articles. Please make sure you're connected to the internet and try again.",
                                                                          preferredStyle: .alert)
                let dismissButton: UIAlertAction = UIAlertAction.init(title: "OK",
                                                                      style: .default,
                                                                      handler: nil)
                alertView.addAction(dismissButton)
                self.present(alertView, animated: true, completion: nil)
            }
            
        }
    }

}
