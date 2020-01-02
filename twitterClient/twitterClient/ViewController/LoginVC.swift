//
//  ViewController.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/19/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - variables

    let twitterServerManager = TwitterServerManager.instance

    //MARK: - IBOutlets

    @IBOutlet weak var signInWithTwitterButton: UIButton!

    //MARK: - Lifrcycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login Page"
        navigationItem.hidesBackButton = true

        NotificationCenter.default.addObserver(self, selector: #selector(openFeedAfterLogin),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }

    //MARK: - IBActions

    @IBAction func signInWithTwitterAction(_ sender: Any) {
        twitterServerManager.doAuthorization()
    }

    @objc func openFeedAfterLogin() {
        if UserDefaults.standard.isUserAuthorized() {
            self.performSegue(withIdentifier: "showFeedScreenAfterLogin", sender: self)
        }
    }
}

