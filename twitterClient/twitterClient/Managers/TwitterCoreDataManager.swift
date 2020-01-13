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

        print(container.persistentStoreDescriptions.first?.url)

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - work with core data
    //saving tweets to Core Data

    func save(tweets: [TweetInfo]) {
        let managedContext = persistentContainer.viewContext

//        let entity = NSEntityDescription.entity(forEntityName: "TweetInfoCoreData", in: managedContext)!
//        let tweetData = NSManagedObject(entity: entity, insertInto: managedContext)
//
//        let _ = tweets.map {
//            tweetData.setValue($0.idStr, forKeyPath: "idStr")
//            tweetData.setValue($0.createdAt, forKeyPath: "createdAt")
//            tweetData.setValue($0.fullText, forKeyPath: "fullText")
//            tweetData.setValue($0.profileImageUrl, forKeyPath: "profileImageUrl")
//            tweetData.setValue($0.name, forKeyPath: "name")
//            tweetData.setValue($0.screenName, forKeyPath: "screenName")
//        }

        tweets.forEach { TweetInfoCoreData(tweetInfo: $0, context: managedContext) }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetch(count: Int, maxId: String? = nil, coredataComplition: (Result<[TweetInfo]>) -> ()) {
        let managedContext = persistentContainer.viewContext

//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TweetInfoCoreData")
        let fetchRequest: NSFetchRequest<TweetInfoCoreData> = TweetInfoCoreData.fetchRequest()

        do {
            self.tweetsCDObjects = try managedContext.fetch(fetchRequest)
            print(self.tweetsCDObjects)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            coredataComplition(.failure(error))
        }

        var tweets = [TweetInfo]()

        self.tweetsCDObjects.forEach {
            tweets.append(TweetInfo.init(CDObject: $0))
        }

        coredataComplition(.success(tweets))
    }

//    func deleteAllData() {
//
//        do {
//            try appDelegate.persistentStoreCoordinator.destroyPersistentStoreAtURL(persistentStoreURL, withType: NSSQLiteStoreType, options: nil)
//
//        } catch {
//            // Error Handling
//        }
//    }

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

