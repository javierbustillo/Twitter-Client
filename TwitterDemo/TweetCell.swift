//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Javier Bustillo on 2/19/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userScreen: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var favoriteCount: UILabel!
  
    @IBOutlet weak var dateCreated: UILabel!
    var tweet: Tweet!{
        didSet{
            tweetLabel.text = tweet.text 
            userLabel.text = tweet.name
            
            userImage.setImageWithURL(tweet.profileUrl!)
            userScreen.text = "@" + (tweet.screenname)!
            retweetCount.text = "\(tweet.retweetCount) retweets"
            favoriteCount.text = "\(tweet.favoritesCount) favorites"
            dateCreated.text = "\(returnTime(tweet.timestamp!)) ago"
        
            
            
            
        }
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
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
