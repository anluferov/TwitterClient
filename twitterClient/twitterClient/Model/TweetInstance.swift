//
//  File.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/19/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation
import UIKit

class TweetInstance: Decodable {

    // info about tweet
    var id: Double
    var created_at: String
    var text: String

    // info about user
    var profile_image_url: URL
    var name: String
    var screen_name: String

    enum CodingKeys: String, CodingKey {
        case id
        case created_at
        case text
        case user
    }

    enum UserCodingKeys: String, CodingKey {
        case profile_image_url
        case name
        case screen_name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Double.self, forKey: .id)
        self.created_at = try container.decode(String.self, forKey: .created_at)
        self.text = try container.decode(String.self, forKey: .text)

        // Nested ratings
        let userContainer = try container.nestedContainer(keyedBy: UserCodingKeys.self, forKey: .user)
        self.profile_image_url = try userContainer.decode(URL.self, forKey: .profile_image_url)
        self.name = try userContainer.decode(String.self, forKey: .name)
        self.screen_name = try userContainer.decode(String.self, forKey: .screen_name)
    }
}

struct TweetInstances: Decodable {
    enum CodingKeys: String, CodingKey {
        case items
    }
    let items: [TweetInstance]
}

