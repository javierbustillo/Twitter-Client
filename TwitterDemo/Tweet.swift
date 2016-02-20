//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Javier Bustillo on 2/19/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var name: String?
    var profileUrl: NSURL?
    var screenname: String?
    
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        name = dictionary["user"]!["name"] as? String
        screenname = dictionary["user"]!["screen_name"] as? String
        
        let profileUrlString = dictionary["user"]!["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString)
            
        }

        
        
        
        let timestampString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
       
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        
    }
    
    
        
    
    
    
    
    
    class func tweetsWithArray(dictionaries : [NSDictionary]) -> [Tweet]{
       var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        
        
        
        return tweets
        
    }
    
}
