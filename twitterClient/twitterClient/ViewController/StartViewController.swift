//
//  StartViewController.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/30/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    //MARK: - variables
    let userManager = UserManager()

    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if userManager.userOauthToken != nil {
            self.performSegue(withIdentifier: "showFeedScreen", sender: self)
        } else {
            self.performSegue(withIdentifier: "showLoginScreen", sender: self)
        }
    }
}
