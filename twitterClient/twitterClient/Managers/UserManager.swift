//
//  UserManager.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 1/15/20.
//  Copyright © 2020 AP Andrey Luferau. All rights reserved.
//

import Foundation
import OAuthSwift
import Alamofire

class UserManager {

    private enum UserDefaultsKeys: String {
        case userScreenName = "ScreenName"
        case userId = "UserId"
        case userOauthToken = "UserOauthToken"
        case userOauthTokenSecret = "UserOauthTokenSecret"
    }

    var userScreenName: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.userScreenName.rawValue) ?? nil
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKeys.userScreenName.rawValue)
        }
    }

    var userId: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.userId.rawValue) ?? nil
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKeys.userId.rawValue)
        }
    }

    var userOauthToken: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.userOauthToken.rawValue) ?? nil
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKeys.userOauthToken.rawValue)
            if value != nil {
                NotificationCenter.default.post(name: .didUserOauthTokenSeted, object: nil)
            }
        }
    }

    var userOauthTokenSecret: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.userOauthTokenSecret.rawValue) ?? nil
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKeys.userOauthTokenSecret.rawValue)
        }
    }

    func setInfoAboutUser(_ parameter: OAuthSwift.Parameters) {
        let screenName = parameter["screen_name"] as? String
        let userId = parameter["user_id"] as? String

        self.userScreenName = screenName
        self.userId = userId
    }

    func setAuthorizationTokens(_ credential: OAuthSwiftCredential) {
        let oauthToken = credential.oauthToken
        let oauthTokenSecret = credential.oauthTokenSecret

        self.userOauthToken = oauthToken
        self.userOauthTokenSecret = oauthTokenSecret
    }

    func cleanAllInfoboutUser() {
        self.userOauthToken = nil
        self.userOauthTokenSecret = nil
        self.userScreenName = nil
        self.userId = nil
    }
}

// NOTE: Notification for understanding of success authorization (after getting of OauthToken)
extension Notification.Name {
    static let didUserOauthTokenSeted = Notification.Name("didUserOauthTokenSeted")
}
