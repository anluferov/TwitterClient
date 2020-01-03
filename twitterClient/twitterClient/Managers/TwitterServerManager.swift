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
    
    static let instance = TwitterServerManager()
    var tweets = Set<TweetInfo>()

    var fetchingInProgress = false

    var tweetsArray: [TweetInfo] {
        return tweets.sorted(by: > )
    }

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
        if let UserOauthToken = UserDefaults.standard.value(forKey: "UserOauthToken") as? String,
            let UserOauthTokenSecret = UserDefaults.standard.value(forKey: "UserOauthTokenSecret") as? String {
                oauthswift.client.credential.oauthToken = UserOauthToken
                oauthswift.client.credential.oauthTokenSecret = UserOauthTokenSecret
        }

        return oauthswift.client
    }

    //MARK: - requests for Twitter API

    // authorize
    func doAuthorization() {
        fetchingInProgress = true
        oauthswift.authorize(
            withCallbackURL: URL(string: "oauth-swift://oauth-callback/twitter")!) { result in
            switch result {
            case .success(let (credential, _, parameters)):
                self.fetchingInProgress = false
                print("Authorization is succesful! \n oauthToken: \(credential.oauthToken) \n oauthTokenSecret:   \(credential.oauthTokenSecret) \n All parameters: \(parameters)")
                UserDefaults.standard.setAuthorizationTokens(credential)

            case .failure(let error):
                self.fetchingInProgress = false
                print(error.localizedDescription)
            }
        }
    }

    // get tweets from Timeline
    func requestForHomeTimeline(count: Int, lastId: String, complition: @escaping (Result<[TweetInfo], Error>) -> ()) {

        let hostHomeTimeline = (host?.appendingPathComponent("statuses/home_timeline.json"))!

        // !!! form parameters, make arguments in function optional
        let maxId = Int(lastId)

        let _ = self.oauthswiftClient.get(hostHomeTimeline, parameters: ["count":count,"max_id":maxId,"exclude_replies":"true"]) { result in
              switch result {
              case .success(let response):

//                NOTE: implementation of parcing from OAuthSwift example
//                let jsonDict = try? response.jsonObject()
//                print(String(describing: jsonDict))

                do {
                    let tweetsFromJSON = try JSONDecoder().decode([TweetJsonInfo].self, from: response.data)
                    let tweets = Set(tweetsFromJSON.map {
                        TweetInfo(idStr: $0.idStr, createdAt: $0.createdAt,
                            text: $0.text, profileImageUrl: $0.profileImageUrl,
                            name: $0.name, screenName: $0.screenName)
                    })
                    complition(.success(tweets.sorted()))
                } catch {
                    complition(.failure(error))
                }
              case .failure(let error):
                self.fetchingInProgress = false
                print(error)
                complition(.failure(error))

              }
          }
    }

}
