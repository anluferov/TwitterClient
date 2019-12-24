//
//  oauthInfoInstance.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/24/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation
import OAuthSwift

struct OauthInfo {

    let item: OAuthSwift?

    init(_ value: OAuthSwift) {
        self.item = value
    }
} 
