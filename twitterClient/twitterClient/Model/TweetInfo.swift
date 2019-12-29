//
//  TwetInfo.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/27/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation

class TweetInfo {

    static var instanses = [TweetInfo]()

    var id: Double?
    var createdAt: String?
    var text: String?
    var user: UserInfo?

    init(id: Double, createdAt: String, text: String, user: UserInfo) {
        self.id = id
        self.createdAt = createdAt
        self.text = text
        self.user = user
    }

    init() {
        
    }
}


