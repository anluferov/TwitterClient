//
//  TwetInfo.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/27/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation

class TweetInfo {
    
    let id: Double
    let createdAt: String
    let text: String
    let profileImageUrl: URL
    let name: String
    let screenName: String

    init (id: Double, createdAt: String, text: String, profileImageUrl: URL, name: String, screenName: String) {
        self.id = id
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
        return lhs.id == rhs.id
    }
}

// MARK: - Comparable

extension TweetInfo: Comparable {
    static func < (lhs: TweetInfo, rhs: TweetInfo) -> Bool {
        return lhs.createdAt < rhs.createdAt
    }
}


// MARK: - Hashable

extension TweetInfo: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id.hashValue)
    }
}
