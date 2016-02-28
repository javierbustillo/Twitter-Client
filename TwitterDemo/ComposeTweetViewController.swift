//
//  ComposeTweetViewController.swift
//  TwitterDemo
//
//  Created by Javier Bustillo on 2/26/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {
    
    var reply: Bool?
    var replyFor: String = ""
    var tweetId: String = ""
    
    
    @IBOutlet weak var tweetField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetField.delegate = self
        tweetField.text = replyFor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tweetButton(sender: AnyObject) {
            print("tweeted!")
        if reply == true{
            TwitterClient.sharedInstance.reply(tweetId, tweetText: "\(tweetField.text)")
                    }else{
            TwitterClient.sharedInstance.composeTweet("\(tweetField.text)")
        }
        dismissViewControllerAnimated(false, completion: nil)
        
            }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
