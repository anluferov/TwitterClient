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


// MARK: - CoreData

class TwitterCoreDataManager {

    var tweetsCDObjects: [NSManagedObject] = []

    // saving tweets to Core Data

    func save(tweets: [TweetInfo]) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "TweetInfoCoreData", in: managedContext)!
        let tweetData = NSManagedObject(entity: entity, insertInto: managedContext)

        let _ = tweets.map {
            tweetData.setValue($0.idStr, forKeyPath: "idStr")
            tweetData.setValue($0.createdAt, forKeyPath: "createdAt")
            tweetData.setValue($0.fullText, forKeyPath: "fullText")
            tweetData.setValue($0.profileImageUrl, forKeyPath: "profileImageUrl")
            tweetData.setValue($0.name, forKeyPath: "name")
            tweetData.setValue($0.screenName, forKeyPath: "screenName")
        }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetch(count: Int, maxId: String? = nil, coredataComplition: (Result<[TweetInfo]>) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TweetInfoCoreData")

        do {
            self.tweetsCDObjects = try managedContext.fetch(fetchRequest)
            print(self.tweetsCDObjects)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            coredataComplition(.failure(error))
        }

        var tweets = [TweetInfo]()

        let _ = self.tweetsCDObjects.map {
            tweets.append(TweetInfo.init(
                    idStr: $0.value(forKeyPath: "idStr") as! String,
                    createdAt: $0.value(forKeyPath: "createdAt") as! String,
                    fullText: $0.value(forKeyPath: "fullText") as! String,
                    profileImageUrl: $0.value(forKeyPath: "profileImageUrl") as! String,
                    name: $0.value(forKeyPath: "name") as! String,
                    screenName: $0.value(forKeyPath: "screenName") as! String
                )
            )
        }

        coredataComplition(.success(tweets))
    }

}

