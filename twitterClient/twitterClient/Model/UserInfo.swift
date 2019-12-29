//
//  UserInfo.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/29/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation

class  UserInfo {

    var profileImageUrl: URL?
    var name: String?
    var screenName: String?

    init(profileImageUrl: URL, name: String, screenName: String) {
        self.profileImageUrl = profileImageUrl
        self.name = name
        self.screenName = screenName
    }

    init() {

    }
}
