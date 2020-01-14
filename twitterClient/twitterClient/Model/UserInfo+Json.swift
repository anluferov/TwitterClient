//
//  UserInfo.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 1/13/20.
//  Copyright © 2020 AP Andrey Luferau. All rights reserved.
//

import Foundation
import UIKit

struct UserInfo: Decodable {

    let profileImageUrlHttps: String
    let defaultProfileImage: Bool

    enum UserJsonRootKeys: String, CodingKey {
        case profileImageUrlHttps = "profile_image_url_https"
        case defaultProfileImage = "default_profile_image"
    }


    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: UserJsonRootKeys.self)

        self.profileImageUrlHttps = try rootContainer.decode(String.self, forKey: .profileImageUrlHttps)
        self.defaultProfileImage = try rootContainer.decode(Bool.self, forKey: .defaultProfileImage)
    }

}
