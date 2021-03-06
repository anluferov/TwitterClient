//
//  File.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/19/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation
import UIKit

extension TweetInfo: Decodable {

    enum TweetJsonRootKeys: String, CodingKey {
        case idStr = "id_str"
        case createdAt = "created_at"
        case fullText = "full_text"
        case user
    }

    enum UserJsonKeys: String, CodingKey {
        case profileImageUrl = "profile_image_url"
        case name
        case screenName = "screen_name"
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: TweetJsonRootKeys.self)

        self.idStr = try rootContainer.decode(String.self, forKey: .idStr)
        self.fullText = try rootContainer.decode(String.self, forKey: .fullText)
        self.createdAt = try rootContainer.decode(String.self, forKey: .createdAt)

        let userContainer = try rootContainer.nestedContainer(keyedBy: UserJsonKeys.self, forKey: .user)
        self.profileImageUrl = try userContainer.decode(String.self, forKey: .profileImageUrl)
        self.name = try userContainer.decode(String.self, forKey: .name)
        self.screenName = try userContainer.decode(String.self, forKey: .screenName)
    }

}

