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

    let twitterServerManager = TwitterServerManager.shared
    let twitterCoreDataManager = TwitterCoreDataManager()

    //MARK: - function for getting tweets from Server or CoreData DB

    func getTweets(forceUpdate: Bool, count: Int, maxId: String?, sinceId: String?, managerComplition: @escaping (Result<[TweetInfo]>) -> ()) {

        twitterServerManager.fetchHomeTimelineTweets(count: count, maxId: maxId, sinceId: sinceId, serverComplition: { result in
            switch result {
            case .success(let tweets):
                managerComplition(.success(tweets))
                self.twitterCoreDataManager.save(forceUpdate: forceUpdate, tweets: tweets)

            case .failure(_):
//                для показа ошибки при случае оффлайна
//                managerComplition(.failure(offlineError))
                self.twitterCoreDataManager.fetch(count: count, maxId: maxId, sinceId: sinceId, coredataComplition: { result in
                    switch result {
                    case .success(let tweets):
                        managerComplition(.success(tweets))
                    case .failure(let error):
                        print(error)
                        managerComplition(.failure(error))
                    }
                })
            }
        })
    }

}
