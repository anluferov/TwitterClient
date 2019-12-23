//
//  TwitterManager.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/22/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation
import OAuthSwift
import Alamofire

class TwitterManager {

    // MARK: - authorization requests to Twitter API

    var oauthToken: String = ""
    var oauthTokenSecret: String = ""

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
            case .success(let (credential, _, parameters)):

              print("Authorization is succesful! \n oauthToken: \(credential.oauthToken) \n oauthTokenSecret: \(credential.oauthTokenSecret) \n All parameters: \(parameters)")

              #warning("TO DO: записывать данные в User Default через объект User")
              UserDefaults.standard.set(credential.oauthToken, forKey: "UserOauthToken")
              UserDefaults.standard.set(credential.oauthTokenSecret, forKey: "UserOauthTokenSecret")
              UserDefaults.standard.set(parameters["screen_name"], forKey: "UserName")
              UserDefaults.standard.setUserAuthorizedState(true)

            case .failure(let error):
              print(error.localizedDescription)
            }
        }
    }

    // MARK: - another requests to Twitter API

    func testRequestWithOAuthSwiftPOD() {
        oauthswift.client.get("https://api.twitter.com/1.1/lists/list.json") { result in
            switch result {
            case .success(let response):
                let dataString = response.string
                print(dataString)
            case .failure(let error):
                print(error)
            }
        }
    }

}
