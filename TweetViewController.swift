//
//  TweetViewController.swift
//  Twitter
//
//  Created by Christian Alexander Valle Castro on 11/6/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    //Mark : Properties
    
    @IBOutlet weak var tweetView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {  // user presses cancel
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        let tweetstring = tweetView.text!
        if(!tweetstring.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString:tweetstring, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error Posting Tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else{
            self.dismiss(animated: true, completion: nil )
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
