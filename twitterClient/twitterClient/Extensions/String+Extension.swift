//
//  String+Extension.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 1/9/20.
//  Copyright © 2020 AP Andrey Luferau. All rights reserved.
//

import Foundation

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
    return dateFormatter
}()

extension String {

    // function for getting time ago string from Twitter created_at date
    func getTimeAgoFormat() -> String? {
        return dateFormatter.date(from:self)?.getTimeAgoInterval()
    }
}
