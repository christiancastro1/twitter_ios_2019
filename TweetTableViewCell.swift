//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Christian Alexander Valle Castro on 10/31/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    //Mark: properties
    
    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var likedTweet:Bool = false // initially tweet is not liked
    var tweetID         = -1
    var retweetval: Bool = false
    
    //Mark :Button Actions
    
    
    @IBAction func retweet(_ sender: Any) {
        let toretweet = !retweetval
        if (toretweet){
            TwitterAPICaller.client?.reTweet(tweetID: tweetID, success: {
                self.Setretweetval(true)
            }, failure: { (error) in
                print("Error retweeting \(error)")
            })
        }
    }
    func Setretweetval(_ reval : Bool){
        retweetval = reval
        if(retweetval){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
                
    }
    
    
    @IBAction func like(_ sender: Any) {  // like button
        let tobeFavore = !likedTweet
        
        if(tobeFavore){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setLike(true)
            }, failure: { (error) in
                print("Error liking Tweet: \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setLike(false)
            }, failure: { (error) in
                print("Cant unlike tweet \(error)")
            })
        }
    }
    
    func setLike(_ liked: Bool){
        likedTweet = liked
        if(likedTweet){
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     

}
