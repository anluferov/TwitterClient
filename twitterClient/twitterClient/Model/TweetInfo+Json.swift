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
        case text
        case user
    }

    enum UserJsonKeys: String, CodingKey {
        case profileImageUrl = "profile_image_url"
        case name
        case screenName = "screen_name"
    }

    init(from decoder: Decoder) throws {
        print("Init from decoder")

        let rootContainer = try decoder.container(keyedBy: TweetJsonRootKeys.self)

        self.idStr = try rootContainer.decode(String.self, forKey: .idStr)
        self.text = try rootContainer.decode(String.self, forKey: .text)
        self.createdAt = try rootContainer.decode(String.self, forKey: .createdAt)

        let userContainer = try rootContainer.nestedContainer(keyedBy: UserJsonKeys.self, forKey: .user)
        self.profileImageUrl = try userContainer.decode(String.self, forKey: .profileImageUrl)
        self.name = try userContainer.decode(String.self, forKey: .name)
        self.screenName = try userContainer.decode(String.self, forKey: .screenName)
    }

}

