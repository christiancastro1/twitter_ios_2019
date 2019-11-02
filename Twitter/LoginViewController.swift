//
//  LoginViewController.swift
//  Twitter
//
//  Created by Christian Alexander Valle Castro on 10/29/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //Mark : properties

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn"){
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    //Marl : Login Action
    @IBAction func loginButton(_ sender: Any) {
        let myUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myUrl, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")// will save so user
        self.performSegue(withIdentifier: "loginToHome", sender:self)
        }, failure: { (Error ) in
            print("could not log in ")
        })
    }
    
   

    /*
    // MARK: - Navigati on

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
