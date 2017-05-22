//
//  NewsTableViewController.swift
//  HNR
//
//  Created by Tiago Alves on 14/03/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit
import SafariServices

let numberOfNews = 20

class NewsTableViewController: UITableViewController {
    
    var allNews : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Trigger refresh news when pull to refres is triggered
        self.refreshControl?.addTarget(self, action: #selector(refreshNews), for: UIControlEvents.valueChanged)
        
        // Start refresh when view is loaded
        self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentOffset.y - 30), animated: false)
        self.tableView.refreshControl?.beginRefreshing()
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

        let news = allNews[indexPath.row] as! News
        cell.set(news: news)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Calculate height of title
        let news = allNews[indexPath.row] as! News
        let title = news.title
        let constraintRect = CGSize(width: tableView.bounds.size.width - 32,
                                    height: CGFloat(MAXFLOAT))
        let boundingBox = title?.boundingRect(with: constraintRect,
                                              options: .usesLineFragmentOrigin,
                                              attributes: [NSFontAttributeName: UIFont(name: "Avenir Next", size: 20) as Any],
                                              context: nil)
        
        return (boundingBox!.height + 57.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = allNews[indexPath.row] as! News
        
        if let url = news.url {
            let safari: SFSafariViewController = SFSafariViewController(url: url)
            safari.preferredBarTintColor = UIColor(red:0.17, green:0.19, blue:0.27, alpha:1.00)
            
            self.present(safari, animated: true, completion: nil)
        }
    }
    
    func refreshNews() {
        API.init().fetchNews(size: numberOfNews) { (news) in
            self.allNews = news as! NSMutableArray
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

}
