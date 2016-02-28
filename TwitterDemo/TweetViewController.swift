//
//  TweetViewController.swift
//  TwitterDemo
//
//  Created by Javier Bustillo on 2/25/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var reTweetLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var screenLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var dateCreated: UILabel!
    var tweets: [Tweet]?
    var index: Int?
    var twit: Tweet!
    var tweetId: String?
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tweet = tweets![index!]
        
        tweetLabel.text = tweet.text
        userLabel.text = tweet.name
        screenLabel.text = "@" + (tweet.screenname)!
        userImage.setImageWithURL(tweet.profileUrl!)
        reTweetLabel.text = "\(tweet.retweetCount) retweets"
        favoriteLabel.text = "\(tweet.favoritesCount) favorites"
        dateCreated.text = "\(returnTime(tweet.timestamp!)) ago"
        tweetId = tweet.tweetID
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnTime(createdAt : NSDate) -> String{
        let seconds = NSDate().timeIntervalSinceDate(createdAt)
        if(seconds < 60){
            return String("\(seconds)s")
        }else{
            let minutes = Int(seconds/60)
            if(minutes > 59){
                let hours = Int(minutes/60)
                if hours > 23{
                    let days = Int(hours/24)
                    return String("\(days)d")
                }else{
                    return String("\(hours)h")
                }
            }else{
                return String("\(minutes)m")
            }
        }
    }
    
    var retweeted = false
    var favorited = false
    var replied = false
    

  /*  @IBAction func replyButton(sender: UIButton) {
        let tweet = tweets![index!]
        if !replied{
            TwitterClient.sharedInstance.reply(tweet.tweetID!)
            replied = true
        }
    }*/
    @IBAction func retweetButton(sender: AnyObject) {
        let tweet = tweets![index!]
        
        if !retweeted {
            
            TwitterClient.sharedInstance.retweet(tweet.tweetID!)
            
            retweeted = true
            reTweetLabel.text = "\(tweet.retweetCount + 1) retweets"
        }
              }

      
    
    @IBAction func replyButton(sender: AnyObject) {
    }
  
    @IBAction func favoriteButton(sender: AnyObject) {
        let tweet = tweets![index!]
        if !favorited {
            TwitterClient.sharedInstance.favorited(tweet.tweetID!)
            
            favorited = true
            favoriteLabel.text = "\(tweet.favoritesCount + 1) favorites"
            
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "reply"{
            let composeTweetController = segue.destinationViewController as! ComposeTweetViewController
            
            let tweet = tweets![index!]
            let replyName  = "@\((tweet.screenname)!) " as String
            
            composeTweetController.tweetId = tweetId!
            
            composeTweetController.replyFor = replyName
            composeTweetController.reply = true
    }
    

}
}


