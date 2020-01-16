//
//  TwitterCoreDataManager.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 1/4/20.
//  Copyright © 2020 AP Andrey Luferau. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Alamofire

class TwitterCoreDataManager {

    var tweetsCDObjects: [TweetInfoCoreData] = []

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TweetInfoModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        //        // information about URL of SQL DB
        //        print(container.persistentStoreDescriptions.first?.url)

        return container
    }()

    // MARK: - work with core data

    //saving tweets to Core Data

    func save(forceUpdate: Bool, tweets: [TweetInfo]) {
        
        if forceUpdate {
            deleteAllDataForTweetInfoCoreDataEntity()
        }

        let managedContext = persistentContainer.viewContext

        tweets.forEach { TweetInfoCoreData(tweetInfo: $0, context: managedContext) }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    // fetching tweets from Core Data

    func fetch(count: Int, maxId: String? = nil, sinceId: String? = nil, coredataComplition: (Result<[TweetInfo]>) -> ()) {

        //NOTE: parametr count haven't used in this method now

        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TweetInfoCoreData> = TweetInfoCoreData.fetchRequest()

        do {
            self.tweetsCDObjects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            coredataComplition(.failure(error))
        }

        var tweets = [TweetInfo]()

        self.tweetsCDObjects.forEach {
            tweets.append(TweetInfo.init(CDObject: $0))
        }

        if let maxId = maxId {
            let tweetsSubrange = tweets.filter { $0.idStr < maxId }
            tweets = tweetsSubrange
        }

        if let sinceId = sinceId {
            let tweetsSubrange = tweets.filter { $0.idStr > sinceId }
            tweets = tweetsSubrange
        }

        coredataComplition(.success(tweets))
    }

    func deleteAllDataForTweetInfoCoreDataEntity() {

        let managedContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TweetInfoCoreData> = TweetInfoCoreData.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)

        do {
            try managedContext.execute(batchDeleteRequest)
        } catch {
            print("Detele all data in TweetInfoCoreDataEntity error :", error)
        }
    }
}

extension TweetInfoCoreData {
    @discardableResult
    convenience init(tweetInfo: TweetInfo, context: NSManagedObjectContext) {
        self.init(context: context)
        idStr = tweetInfo.idStr
        createdAt = tweetInfo.createdAt
        fullText = tweetInfo.fullText
        profileImageUrl = tweetInfo.profileImageUrl
        name = tweetInfo.name
        screenName = tweetInfo.screenName
    }
}

