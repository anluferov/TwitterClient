//
//  ViewController.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/19/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    let twitterManager = TwitterManager.instance
    var tweetsInfo = TwitterManager.tweetsInfo

    @IBOutlet weak var signInWithTwitterButton: UIButton!
    @IBOutlet weak var openFeedButton: UIButton!
    @IBOutlet weak var cleanAuthorisedStateButton: UIBarButtonItem!

    override func loadView() {
        print(#function)

        super.loadView()
    }

    override func viewDidLoad() {
        print(#function)
        
        super.viewDidLoad()
        title = "Login Page"
        refreshViewController()

        NotificationCenter.default.addObserver(self, selector: #selector(refreshViewController),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }

    @IBAction func signInWithTwitterAction(_ sender: Any) {
        print(#function)
        twitterManager.doAuthorization()
    }

    @IBAction func cleanAuthorisedStateAction(_ sender: Any) {
        print(#function)
        UserDefaults.standard.setUserAuthorizedState(false)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFeed" {
            if let _ = segue.destination as? TweetFeedTableViewController {
//                need to write actions
//                addItemViewController.delegate = self
//                addItemViewController.todoList = todoList
            }
        }
    }

    @objc func refreshViewController() {
        if UserDefaults.standard.isUserAuthorized() {
            signInWithTwitterButton.isHidden = true
            openFeedButton.isHidden = false
        } else {
            signInWithTwitterButton.isHidden = false
            openFeedButton.isHidden = true
        }
    }
}

