//
//  NewsTableViewController.swift
//  HNR
//
//  Created by Tiago Alves on 14/03/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

let maxNumberOfNews = 30

class NewsTableViewController: UITableViewController {
    
    var allNews : Array<News> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set automatic height calculation for cells
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85.0
        
        // Trigger refresh news when pull to refres is triggered
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: UIControlEvents.valueChanged)
        
        // Start refresh when view is loaded
        tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentOffset.y - 30), animated: false)
        tableView.refreshControl?.beginRefreshing()
        refreshNews()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        cell.addGestureRecognizer(longPressRecognizer)
        
        let news = allNews[indexPath.row]
        cell.set(news: news)
        
        cell.commentsButton?.indexPath = indexPath

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = allNews[indexPath.row]
        
        if let url = news.url {
            let safari: CustomWebViewController = CustomWebViewController(url: url)
            present(safari, animated: true, completion: nil)
        }
    }
    
    func refreshNews() {
        API.sharedInstance.fetchNews(size: maxNumberOfNews) { (success, news) in
            
            // Update array of news and interface
            self.allNews = news
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
    
    
    @IBAction func longPressed(sender: UILongPressGestureRecognizer)
    {
        let newsCell:NewsCell = (sender.view as? NewsCell)!
        if let myWebsite = newsCell.news?.url {
            let objectsToShare = [myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare,
                                                      applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comments" {
            let commentsViewController = segue.destination as! CommentsTableViewController
            let button = sender as! CommentsButton
            let indexPath = button.indexPath!
            let news = allNews[indexPath.row]
            let commentsIds = news.commentsIds
            commentsViewController.commentsIds = commentsIds
        }
    }

}
