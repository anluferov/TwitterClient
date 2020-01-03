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

    var tweets = [TweetInfo]()

    func getTweets(count: Int?, lastId: String?, complition: @escaping (Result<[TweetInfo], Error>) -> ()) {

        twitterServerManager.requestForHomeTimeline(count: count, lastId: lastId) { [weak self] result in
            switch result {
            case .success(let tweets):
                if lastId == nil {
                    self?.tweets.removeAll()
                }
                self?.tweets.append(contentsOf: tweets)

            case .failure(let error):
                // show error
                break
            }
        }
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
