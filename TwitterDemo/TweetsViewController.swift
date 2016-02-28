//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Javier Bustillo on 2/19/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit
import MBProgressHUD

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
   
    @IBOutlet weak var tableView: UITableView!
   
   

    var tweets: [Tweet]?
   
    
    @IBOutlet weak var tweetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets{
                print(tweet.text)
                self.tableView.reloadData()
            }
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
        
    }

        
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets{
            return tweets.count
        }
            return 0
        
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.selectionStyle = .None
        
        cell.tweet = tweets![indexPath.row]
       
        
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue"{
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let index = indexPath!.row
            let tweetViewController = segue.destinationViewController as! TweetViewController
            
            tweetViewController.tweets = tweets
            tweetViewController.index = index
            }
        if segue.identifier == "compose"{
            segue.destinationViewController as! ComposeTweetViewController
        
        }
      /*  if segue.identifier == "reply"{
            let button = sender as! UIButton
            let buttonFrame = button.convertRect(button.bounds, toView: self.tableView)
            if let indexPath = self.tableView.indexPathForRowAtPoint(buttonFrame.origin) {
                let composeTweetViewController = segue.destinationViewController as! ComposeTweetViewController
                
                let selectedRow = indexPath.row as NSInteger
                
                let tweet = tweets![selectedRow]
                let replyName  = "@\(tweet.screenname!) " as String
                
                composeTweetViewController.tweetId = (tweet.tweetID!)
                composeTweetViewController.replyFor = replyName
                composeTweetViewController.reply = true
        }*/
        if segue.identifier == "user"{
            
            let button = sender as! UIButton
            let buttonFrame = button.convertRect(button.bounds, toView: self.tableView)
            if let indexPath = self.tableView.indexPathForRowAtPoint(buttonFrame.origin) {
                let userControllerView = segue.destinationViewController as! UserViewController
                
                let selectedRow = indexPath.row as NSInteger
                
                userControllerView.tweets = tweets
                userControllerView.index = selectedRow
        }
        
            
            
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
    }
