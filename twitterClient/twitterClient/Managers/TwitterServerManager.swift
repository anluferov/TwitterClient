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

class TwitterServerManager {

    let host = URL(string: "https://api.twitter.com/1.1/")
    
    var tweets = [TweetInfo]()

    // create an instance and retain it
    let oauthswift = OAuth1Swift(
        consumerKey:    "MeVFWwIRcqjx3jOdT3WTF2za7",
        consumerSecret: "2HT6sXOIWzQZ9my8KY906GBxo5cd4hHzGZdt2d8DicAYncfN1J",
        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
    )

    // set for oauthswift instance tokens for requests
    var oauthswiftClient: OAuthSwiftClient {
        if let userOauthToken = UserDefaults.standard.value(forKey: "UserOauthToken") as? String,
            let userOauthTokenSecret = UserDefaults.standard.value(forKey: "UserOauthTokenSecret") as? String {
                oauthswift.client.credential.oauthToken = userOauthToken
                oauthswift.client.credential.oauthTokenSecret = userOauthTokenSecret
        }

        return oauthswift.client
    }

    //MARK: - requests for Twitter API

    // authorize
    func doAuthorization() {
        oauthswift.authorize(
            withCallbackURL: URL(string: "oauth-swift://oauth-callback/twitter")!) { result in
            switch result {
            case .success(let (credential, _, parameters)):
                print("Authorization is succesful! \n oauthToken: \(credential.oauthToken) \n oauthTokenSecret:   \(credential.oauthTokenSecret) \n All parameters: \(parameters)")
                UserDefaults.standard.setAuthorizationTokens(credential)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // get tweets from Timeline
    func fetchHomeTimelineTweets(count: Int, maxId: String?, sinceId: String?, serverComplition: @escaping (Result<[TweetInfo]>) -> ()) {

        let hostHomeTimeline = (host?.appendingPathComponent("statuses/home_timeline.json"))!

        var httpParameters: OAuthSwift.Parameters = ["count": count,
                                                 "exclude_replies": "true",
                                                 "tweet_mode": "extended"
        ]
        if let maxId = maxId {
            httpParameters["max_id"] = maxId
        }

        if let sinceId = sinceId {
            httpParameters["since_id"] = sinceId
        }

        let _ = self.oauthswiftClient.get(hostHomeTimeline, parameters: httpParameters) { result in
              switch result {
              case .success(let response):

//                NOTE: implementation of parcing from OAuthSwift example
//                let jsonDict = try? response.jsonObject()
//                print(String(describing: jsonDict))

                do {
                    let tweets = try JSONDecoder().decode([TweetInfo].self, from: response.data)
                    serverComplition(.success(tweets))
                } catch {
                    serverComplition(.failure(error))
                }
                
              case .failure(let error):
                print(error)
                serverComplition(.failure(error))

              }
          }
    }

}
