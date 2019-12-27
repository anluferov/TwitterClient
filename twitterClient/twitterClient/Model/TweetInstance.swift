//
//  File.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/19/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation
import UIKit

struct TweeterInfo: Decodable {
    var id: Double
    var createdAt: String
    var text: String
    var profileImageUrl: URL
    var name: String
    var screenName: String

    enum TweetJsonRootKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case text
        case user
    }

    enum UserJsonKeys: String, CodingKey {
        case profileImageUrl = "profile_image_url"
        case name
        case screenName = "screen_name"
    }

    init(from decoder: Decoder) throws {
        print("Into init")

        let rootContainer = try decoder.container(keyedBy: TweetJsonRootKeys.self)

        self.id = try rootContainer.decode(Double.self, forKey: .id)
        self.createdAt = try rootContainer.decode(String.self, forKey: .createdAt)
        self.text = try rootContainer.decode(String.self, forKey: .text)

        let userContainer = try rootContainer.nestedContainer(keyedBy: UserJsonKeys.self, forKey: .user)
        self.profileImageUrl = try userContainer.decode(URL.self, forKey: .profileImageUrl)
        self.name = try userContainer.decode(String.self, forKey: .name)
        self.screenName = try userContainer.decode(String.self, forKey: .screenName)
    }
}

