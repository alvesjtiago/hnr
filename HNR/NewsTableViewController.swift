//
//  NewsTableViewController.swift
//  HNR
//
//  Created by Tiago Alves on 14/03/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices

class NewsTableViewController: UITableViewController {
    
    var allNews : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News"
        
        var counter = 0
        
        Alamofire.request("https://hacker-news.firebaseio.com/v0/topstories.json").responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                let arrayOfNews = response.result.value as! NSArray
                for news in arrayOfNews.subarray(with: NSRange(location: 0, length: 10)) {
                    Alamofire.request("https://hacker-news.firebaseio.com/v0/item/\(news).json").responseJSON { response in
                        counter += 1
                        if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                            self.allNews.add(JSON)
                        }
                        if counter == 10 {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
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
        return self.allNews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)

        let news = self.allNews[indexPath.row] as! NSDictionary
        
        let titleLabel = cell.contentView.viewWithTag(100) as! UILabel
        titleLabel.text = news.value(forKey: "title") as? String
        
        let scoreLabel = cell.contentView.viewWithTag(101) as! UILabel
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = 11
        scoreLabel.text = String(describing: news.value(forKey: "score") as! Int)
        
        let byLabel = cell.contentView.viewWithTag(102) as! UILabel
        if news.value(forKey: "by") != nil {
            let author = news.value(forKey: "by")
            let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
            let boldString = NSMutableAttributedString(string: author as! String, attributes: attrs)
            
            let attributedString = NSMutableAttributedString(string:"by ")
            attributedString.append(boldString)
            
            byLabel.attributedText = attributedString
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = self.allNews[indexPath.row] as! NSDictionary
        
        if let url = news.value(forKey: "url") {
            let destination: URL = URL(string: url as! String)!
            
            let safari: SFSafariViewController = SFSafariViewController(url: destination)
            safari.preferredBarTintColor = UIColor(red:0.17, green:0.19, blue:0.27, alpha:1.00)
            
            self.present(safari, animated: true, completion: nil)
            
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
