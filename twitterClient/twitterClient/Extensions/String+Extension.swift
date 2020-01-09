//
//  String+Extension.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 1/9/20.
//  Copyright © 2020 AP Andrey Luferau. All rights reserved.
//

import Foundation

extension String {

    // function for getting time ago string from Twitter created_at date
    func getTimeAgoFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        let createdAtDate = dateFormatter.date(from:self)
        let timeAgoString = createdAtDate?.getTimeAgoInterval()
        return timeAgoString
    }
}
