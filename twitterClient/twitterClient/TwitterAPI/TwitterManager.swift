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

    static let instance = TwitterManager()

    // MARK: - authorization requests to Twitter API

    // create an instance and retain it
    let oauthswift = OAuth1Swift(
        consumerKey:    "MeVFWwIRcqjx3jOdT3WTF2za7",
        consumerSecret: "2HT6sXOIWzQZ9my8KY906GBxo5cd4hHzGZdt2d8DicAYncfN1J",
        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
    )

//    var client: OAuthSwiftClient {
//        return oauthswift.client
//    }

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

//              self.item = OauthInfo.init(self.oauthswift)
              self.testRequestWithOAuthSwiftPOD()

            case .failure(let error):
              print(error.localizedDescription)
            }
        }
    }

    // MARK: - another requests to Twitter API

//    func testRequestWithOAuthSwiftPOD(_ oauthswift: OAuth1Swift) {
    func testRequestWithOAuthSwiftPOD() {
        let requestCustom = self.oauthswift.client.get("https://api.twitter.com/1.1/account/verify_credentials.json", parameters: [:]) { result in
              switch result {
              case .success(let response):
                  let jsonDict = try? response.jsonObject()
                  print(String(describing: jsonDict))
              case .failure(let error):
                  print(error)
              }
          }
    }

    func prepareHeaders() -> HTTPHeaders? {

        let oauth_consumer_key = self.oauthswift.client.credential.consumerKey
//        let oauth_nonce
//        let oauth_signature
//        let oauth_signature_method
//        let oauth_timestamp
//        let oauth_token = UserDefaults.standard.value(forKey: "UserOauthToken") as? String

        if let oauth_token = UserDefaults.standard.value(forKey: "UserOauthToken") as? String,
            let _ = UserDefaults.standard.value(forKey: "UserOauthTokenSecret") as? String {
            let stringValue = "OAuth oauth_consumer_key=" + "\(oauth_consumer_key)" + ",oauth_token=" + "\(oauth_token)"
                return [.authorization(stringValue)]
        }

        return nil


    }

    func requestForAccountSettings() {
        if let headers = prepareHeaders() {
            AF.request("https://api.twitter.com/1.1/account/settings.json", headers: headers)
                .responseJSON { response in
                    debugPrint(response)
                }
        }
    }




}
