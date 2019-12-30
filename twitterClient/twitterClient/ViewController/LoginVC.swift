//
//  ViewController.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/19/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let twitterManager = TwitterManager.instance
    var tweetsInfo = TwitterManager.tweetsInfo

    @IBOutlet weak var signInWithTwitterButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login Page"
        navigationItem.hidesBackButton = true

        NotificationCenter.default.addObserver(self, selector: #selector(openFeedAfterLogin),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }

    @IBAction func signInWithTwitterAction(_ sender: Any) {
        twitterManager.doAuthorization()
    }

    @objc func openFeedAfterLogin() {
        if UserDefaults.standard.isUserAuthorized() {
            self.performSegue(withIdentifier: "showFeedScreenAfterLogin", sender: self)
        }
    }
}

