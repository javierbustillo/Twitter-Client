//
//  User.swift
//  TwitterDemo
//
//  Created by Javier Bustillo on 2/19/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
   // var followingNumber: Int?
    var followerNumber: Int?
    var tweetNumber: Int?
    
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
       
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString)
            
        }
        tagline = dictionary["description"] as? String
       
       // followingNumber = dictionary["user"]!["friends_count"] as? Int
               
        
        
        }
   
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?
    
    class var currentUser: User?{
        get{
            if _currentUser == nil{
        
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let userData = defaults.objectForKey("currentUserData") as? NSData
        
            if let userData = userData{
            let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
            _currentUser = User(dictionary: dictionary)
        
        }
        }
        return _currentUser
        }
       
        set(user){
            
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
         
            if let user = user{
           let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
                
            }else{
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
           
            defaults.synchronize()
        }
    }
    
}
