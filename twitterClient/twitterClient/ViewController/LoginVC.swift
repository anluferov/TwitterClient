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

    //MARK: - IBOutlets
    @IBOutlet weak var signInWithTwitterButton: UIButton!

    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Login Page"
        navigationController?.navigationBar.barTintColor = UIColor.systemTeal
        navigationItem.hidesBackButton = true

        NotificationCenter.default.addObserver(forName: .didUserOauthTokenSeted, object: nil, queue: .main) { _ in
                self.performSegue(withIdentifier: "showFeedScreenAfterLogin", sender: self)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    //MARK: - IBActions
    @IBAction func signInWithTwitterAction(_ sender: Any) {
        twitterServerManager.doAuthorization()
    }
}

