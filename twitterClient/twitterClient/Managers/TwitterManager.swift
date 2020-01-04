//
//  TwitterServerManager.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 1/1/20.
//  Copyright © 2020 AP Andrey Luferau. All rights reserved.
//

import Foundation
import OAuthSwift
import Alamofire

class TwitterManager {

    let twitterServerManager = TwitterServerManager.instance

    static let instance = TwitterManager()

    func getTweets(count: Int, maxId: String?, managerComplition: @escaping (Result<[TweetInfo]>) -> ()) {

        twitterServerManager.requestForHomeTimeline(count: count, maxId: maxId, serverComplition: { result in
            switch result {
            case .success(let tweets):
                managerComplition(.success(tweets.sorted(by: > )))
                // store tweets in Core Data async
                
            case .failure(let error):
                // get tweets from Core Data sync
                print(error)
                managerComplition(.failure(error))
            }
        })
    }


    func tweetsForTimeline() -> [TweetInfo] {

        let _ = twitterServerManager.tweets.map {
            print($0.idStr)
            print($0.createdAt)
            print($0.name)
            print($0.screenName)
            print($0.profileImageUrl)
            print($0.text)
        }

        return twitterServerManager.tweets.sorted(by: > )
    }

}
