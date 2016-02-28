//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Javier Bustillo on 2/19/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "xAb5OfjH51OPjLKqmrVhQaObG", consumerSecret: 	"m2G1Ub91Vvr3mKAdR2Dtxz0s3PJMrOpqEIVE6lRRU40LdvwZXS")
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
        
        
           }
    func currentAccount(success: (User) -> (), failure: (NSError) -> () ){
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
           
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
           
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
            
            
            
            self.loginSuccess?()
            
            
           
            
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func getUser(screenname: String, completion: (tweet: [Tweet]?, error: NSError?)-> ()) {
        GET("1.1/statuses/user_timeline.json?screen_name=\(screenname)", parameters: nil,
            success: { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                completion(tweet: tweets, error: nil)
            },
            
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Error retrieving info: \(error)")
                
                
        })
        
    }
    
    func reply(tweetId: String, tweetText: String){
        let escapedText = (tweetText.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding))!
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json?status=\(escapedText)&in_reply_to_status_id=\(tweetId)", parameters: nil, success: { (operation:NSURLSessionDataTask, response:AnyObject?) -> Void in
            print("replied")
            }) { (operation:NSURLSessionDataTask?, error:NSError) -> Void in
                print("failed to reply")
        }
    }
    
    func retweet(id:String) {
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(id).json", parameters:nil , success: { (operation:NSURLSessionDataTask?, response:AnyObject?) -> Void in
            print("successfully retweeted")
            print(response)
            }) { (operation:NSURLSessionDataTask?, error:NSError!) -> Void in
                print("failed to retweet")
        }
    }
    
        
        
        func favorited(id:String) {
            TwitterClient.sharedInstance.POST("1.1/favorites/create.json?id=\(id)", parameters:nil , success: { (operation:NSURLSessionDataTask?, response:AnyObject?) -> Void in
                print("successfully favorited")
                print(response)
                }) { (operation:NSURLSessionDataTask?, error:NSError!) -> Void in
                    print("failed to favorited")
            }
        }
    
    
    func composeTweet(tweetField:String){
        
        let escapedText = (tweetField.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding))!

        
        
        TwitterClient.sharedInstance.POST("1.1/statuses/update.json?status=\(escapedText)", parameters:nil, success: { (operation:NSURLSessionDataTask?, response:AnyObject?) -> Void in
            print("succesfully tweeted")
            
            
            }) { (operation:NSURLSessionDataTask?, error:NSError!) -> Void in
                print("failed to tweet")
                
        }
    }
    
    func logout(){
        User.currentUser = nil
        
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
   
        
    func login(success: () -> (), failure: (NSError)-> ()){
        loginSuccess = success
        loginFailure = failure
        
        
        deauthorize()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
        }

    }

