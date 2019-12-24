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

    @IBOutlet weak var signInWithTwitterButton: UIButton!
    @IBOutlet weak var openFeedButton: UIButton!
    @IBOutlet weak var cleanAuthorisedStateButton: UIButton!

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

    @IBAction func cleanAuthorisedStateAction(_ sender: Any) {
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

