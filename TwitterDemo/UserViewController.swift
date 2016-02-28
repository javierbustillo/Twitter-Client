//
//  UserViewController.swift
//  TwitterDemo
//
//  Created by Javier Bustillo on 2/26/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
   
    
    @IBOutlet weak var followerNumberLabel: UILabel!
    @IBOutlet weak var followingNumberLabel: UILabel!
    @IBOutlet weak var tweetNumberLabel: UILabel!
    @IBOutlet weak var bannerLabel: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    var index: Int?
    var screenname: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tweet = tweets![index!]
        
        
        screenname = tweet.screenname!
        
        userLabel.text = (tweet.name)!
        screennameLabel.text = ("@" + tweet.screenname!)
        profileImage.setImageWithURL(tweet.profileUrl!)
      //  bannerLabel.setImageWithURL(tweet.bannerUrl!)
        followerNumberLabel.text = ("\(tweet.followerNumber) followers")
        followingNumberLabel.text = "\(tweet.followingNumber) friends"
        tweetNumberLabel.text = "\(tweet.tweetNumber) tweets"
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        
        TwitterClient.sharedInstance.getUser(screenname) { (tweets, error) -> () in
                self.tweets = tweets
            
            
                self.tableView.reloadData()

        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets{
            return tweets.count
        }
        return 0
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        cell.tweetid = cell.tweet.tweetID
        cell.tweetLabel.sizeToFit()
        cell.selectionStyle = .None
        return cell
        
        
        
    
        return cell
    }

    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
    if segue.identifier == "detail"{
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let index = indexPath!.row
        let tweetViewController = segue.destinationViewController as! TweetViewController
        
        tweetViewController.tweets = tweets
        tweetViewController.index = index

    }
    

}
}