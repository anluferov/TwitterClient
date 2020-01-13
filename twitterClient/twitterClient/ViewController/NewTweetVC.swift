//
//  NewTweetVC.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 1/13/20.
//  Copyright © 2020 AP Andrey Luferau. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class NewTweetViewController: UIViewController {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!

    let twitterServerManager = TwitterServerManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        twitterServerManager.fetchUserImage(serverComplition: { result in
            switch result {
            case .success(let userInfo):
                let avatarProfileUrl = URL(string: userInfo.profileImageUrlHttps)!
                self.userAvatar.af_setImage(
                    withURL: avatarProfileUrl,
                    filter: CircleFilter()
                )

            case .failure(_):
                break
            }
        })
    }


}
