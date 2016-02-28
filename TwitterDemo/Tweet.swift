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
    var tweetID: String?
    var user: User?
    var bannerUrl: NSURL?
    var followingNumber: Int!
    var followerNumber: Int!
    var tweetNumber: Int!
    var Index: Int!
    
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        name = dictionary["user"]!["name"] as? String
        screenname = dictionary["user"]!["screen_name"] as? String
        
       let bannerUrlString = dictionary["user"]!["profile_background_image_url"] as? String
        if let bannerUrlString = bannerUrlString{
            bannerUrl = NSURL(string: bannerUrlString)
            tweetID = (dictionary["id_str"] as! String?)!
        }
        
        
        let profileUrlString = dictionary["user"]!["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString)
            tweetID = (dictionary["id_str"] as! String?)!
            
        }
        followingNumber = dictionary["user"]!["friends_count"] as! Int
        followerNumber = dictionary["user"]!["followers_count"] as? Int
        tweetNumber = dictionary["user"]!["statuses_count"] as? Int

        
        
        
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
