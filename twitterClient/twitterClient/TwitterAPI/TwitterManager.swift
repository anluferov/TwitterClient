//
//  TwitterManager.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/22/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation
import OAuthSwift

class TwitterManager {

    // create an instance and retain it
    var oauthswift = OAuth1Swift(
        consumerKey:    "MeVFWwIRcqjx3jOdT3WTF2za7",
        consumerSecret: "2HT6sXOIWzQZ9my8KY906GBxo5cd4hHzGZdt2d8DicAYncfN1J",
        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
    )

    // authorize
    func doAuthorization() {
        oauthswift.authorize(
            withCallbackURL: URL(string: "oauth-swift://oauth-callback/twitter")!) { result in
            switch result {
            case .success(let (credential, response, parameters)):
              print("Authorization is succesful! \n oauthToken: \(credential.oauthToken) \n oauthTokenSecret: \(credential.oauthTokenSecret) \n All parameters: \(parameters)")
            case .failure(let error):
              print(error.localizedDescription)
            }
        }
    }


}
