//
//  StartViewController.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/30/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if UserDefaults.standard.isUserAuthorized() {
            self.performSegue(withIdentifier: "showFeedScreen", sender: self)
        } else {
            self.performSegue(withIdentifier: "showLoginScreen", sender: self)
        }
    }
}
