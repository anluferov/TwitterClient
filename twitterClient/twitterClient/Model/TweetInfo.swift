//
//  TwetInfo.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/27/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation

class TweetInfo {

    var id: Double?
    var createdAt: String?
    var text: String?
    var profileImageUrl: URL?
    var name: String?
    var screenName: String?

    init(id: Double, createdAt: String, text: String, profileImageUrl: URL, name: String, screenName: String) {
        self.id = id
        self.createdAt = createdAt
        self.text = text
        self.profileImageUrl = profileImageUrl
        self.name = name
        self.screenName = screenName
    }

    init() {
        
    }
}


