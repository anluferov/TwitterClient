//
//  File.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/19/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import Foundation
import UIKit

struct User {

    #warning("TODO: сделать нормальный сеттер значений. Записывать данные в UserDefault после изменений значений в этом объекте")

    let userName: String?
    let oauthToken: String?
    let oauthTokenSecret: String?

    let isAuthorised: Bool = false
}
