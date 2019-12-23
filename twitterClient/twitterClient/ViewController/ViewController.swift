//
//  ViewController.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/19/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let twitterManager = TwitterManager()

    @IBOutlet weak var signInWithTwitterButton: UIButton!

    override func loadView() {
        print(#function)

        super.loadView()
    }

    override func viewDidLoad() {
        print(#function)
        
        super.viewDidLoad()
        refreshViewController()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshViewController),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }

    @IBAction func signInWithTwitterAction(_ sender: Any) {
        twitterManager.doAuthorization()
    }

    @objc func refreshViewController() {
        if UserDefaults.standard.isUserAuthorized() {
            signInWithTwitterButton.isHidden = true
        }
    }
}

