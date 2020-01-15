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

    let twitterManager = TwitterManager()
    let twitterServerManager = TwitterServerManager.shared

//    var isUserAuthorised: Bool? = nil {
//        didSet {
//            if let isUserAuthorised = isUserAuthorised {
//                if isUserAuthorised {
//                    self.performSegue(withIdentifier: "showFeedScreenAfterLogin", sender: self)
//                }
//            }
//        }
//    }

    //MARK: - IBOutlets

    @IBOutlet weak var signInWithTwitterButton: UIButton!

    //MARK: - Lifrcycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login Page"
        navigationItem.hidesBackButton = true

//        NotificationCenter.default.addObserver(self,
//                                               forKeyPath: "IsUserAuthorised",
//                                               options: NSKeyValueObservingOptions.new,
//                                               context: nil)

//        UserDefaults.standard.removeObserver(self, forKeyPath: "Gift")

        NotificationCenter.default.addObserver(self, selector: #selector(openFeedAfterLogin),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }



    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(#function)
        openFeedAfterLogin()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    //MARK: - IBActions

    @IBAction func signInWithTwitterAction(_ sender: Any) {
        twitterServerManager.doAuthorization()
    }

    @objc func openFeedAfterLogin() {
        if UserDefaults.standard.isUserAuthorized() {
            self.performSegue(withIdentifier: "showFeedScreenAfterLogin", sender: self)
        }

//        if UserDefaults.standard.isUserAuthorized() {
//            self.performSegue(withIdentifier: "showFeedScreenAfterLogin", sender: self)
//        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        print(#function)
        print("!!!!!")
    }
}

