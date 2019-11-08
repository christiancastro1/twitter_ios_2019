//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Christian Alexander Valle Castro on 10/30/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit
class HomeTableTableViewController: UITableViewController {
    //Mark: properties
    var tweetsArray = [NSDictionary]()
    var numberoftweets : Int!
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        numberoftweets = 20
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    @objc func loadTweets(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParameters = ["count": numberoftweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParameters , success:
            {(tweets: [NSDictionary]) in
                self.tweetsArray.removeAll()
                for tweet in tweets{
                    self.tweetsArray.append(tweet) // the resposne tweets, we want to save it to our local dictionary
                }

                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing() // to stop refresh icon
                 
        }, failure: { (Error) in
            print("Cant get tweets dictionary")
        })
        

    }
    override func viewDidAppear(_ animated: Bool) {
        //self.viewDidAppear(animated)
        self.loadTweets()
}
    func loadMoreTweets (){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberoftweets += 20
        let myParameters = ["count": numberoftweets]
               TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParameters , success:
                   {(tweets: [NSDictionary]) in
                       self.tweetsArray.removeAll()
                       for tweet in tweets{
                           self.tweetsArray.append(tweet) // the resposne tweets, we want to save it to our local dictionary
                       }
                       self.tableView.reloadData()
                        
               }, failure: { (Error) in
                   print("Cant get tweets dictionary :)")
               })
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row+1 == tweetsArray.count{
            loadMoreTweets()
        }
    } 
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
       }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetsArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as!  TweetTableViewCell
        
        let user = tweetsArray[indexPath.row]["user"] as! NSDictionary
        
        cell.tweetLabel.text = tweetsArray[indexPath.row]["text"] as! String
        cell.nameLabel.text  = user["name"] as! String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.imageView?.image  = UIImage(data:imageData)
        }
        cell.setLike(tweetsArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetID = tweetsArray[indexPath.row]["id"] as! Int
        cell.Setretweetval(tweetsArray[indexPath.row]["retweeted"] as! Bool)
        
    
        return cell
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
