//
//  UserDefaults+Extension.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/23/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation

extension UserDefaults {

    func setUserAuthorizedState( _ value: Bool) {
        if value {
            set(true, forKey: "IsUserAuthorised")
        } else {
            set(false, forKey: "IsUserAuthorised")
        }
    }

    func isUserAuthorized() -> Bool {
        if let value = value(forKey: "IsUserAuthorised") as? Bool {
            return value
        } else {
            return false
        }
    }

}
