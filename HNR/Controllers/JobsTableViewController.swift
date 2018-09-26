//
//  JobsTableViewController.swift
//  HNR
//
//  Created by Tiago Alves on 17/09/2017.
//  Copyright © 2017 Tiago Alves. All rights reserved.
//

import UIKit

let maxNumberOfJobs = 30

class JobsTableViewController: UITableViewController {

    var allJobs : Array<Job> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set automatic height calculation for cells
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85.0
        
        // Trigger refresh jobs when pull to refres is triggered
        refreshControl?.addTarget(self, action: #selector(refreshJobs), for: UIControlEvents.valueChanged)
        
        // Start refresh when view is loaded
        tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentOffset.y - 30), animated: false)
        tableView.refreshControl?.beginRefreshing()
        refreshJobs()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allJobs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobCell
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        cell.addGestureRecognizer(longPressRecognizer)
        
        let job = allJobs[indexPath.row]
        cell.set(job: job)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let job = allJobs[indexPath.row]
        
        if let url = job.url {
            let safari: CustomWebViewController = CustomWebViewController(url: url)
            present(safari, animated: true, completion: nil)
        }
    }
    
    func refreshJobs() {
        API.sharedInstance.fetchJobs(size: maxNumberOfJobs) { (success, jobs) in
            
            // Update array of jobs and interface
            self.allJobs = jobs
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            
            if (!success) {
                // Display error
                let alertView: UIAlertController = UIAlertController.init(title: "Error fetching jobs",
                                                                          message: "There was an error fetching the new Hacker News jobs. Please make sure you're connected to the internet and try again.",
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
        let jobCell:JobCell = (sender.view as? JobCell)!
        if let myWebsite = jobCell.job?.url {
            let objectsToShare = [myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare,
                                                      applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }

}
