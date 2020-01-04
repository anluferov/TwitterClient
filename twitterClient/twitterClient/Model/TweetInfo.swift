//
//  TwetInfo.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/27/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation
import UIKit

struct TweetInfo {
    
    let idStr: String
    let createdAt: String
    let text: String
    let profileImageUrl: String
    let name: String
    let screenName: String

    init (idStr: String, createdAt: String, text: String, profileImageUrl: String, name: String, screenName: String) {
        self.idStr = idStr
        self.createdAt = createdAt
        self.text = text
        self.profileImageUrl = profileImageUrl
        self.name = name
        self.screenName = screenName
    }
}


// MARK: - Equatable

extension TweetInfo: Equatable {
    static func == (lhs: TweetInfo, rhs: TweetInfo) -> Bool {
        return lhs.idStr == rhs.idStr
    }
}

// MARK: - Comparable

extension TweetInfo: Comparable {
    static func < (lhs: TweetInfo, rhs: TweetInfo) -> Bool {
        return lhs.idStr < rhs.idStr
    }
}

// MARK: - Hashable

extension TweetInfo: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(idStr.hashValue)
    }
}
