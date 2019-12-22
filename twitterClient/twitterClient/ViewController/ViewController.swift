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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func signInWithTwitterAction(_ sender: Any) {
        twitterManager.doAuthorization()
    }


    

}

