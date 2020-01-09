//
//  Date+Extension.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 1/9/20.
//  Copyright © 2020 AP Andrey Luferau. All rights reserved.
//

import Foundation

extension Date {

    func getTimeAgoInterval() -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())

        if let year = interval.year, year > 0 {
            return "\(year)" + " " + "y."
        } else if let month = interval.month, month > 0 {
            return "\(month)" + " " + "m."
        } else if let day = interval.day, day > 0 {
            return "\(day)" + " " + "d."
        } else if let hour = interval.hour, hour > 0 {
            return "\(hour)" + " " + "h."
        } else if let minute = interval.minute, minute > 0 {
            return "\(minute)" + " " + "min."
        } else if let second = interval.second, second > 1 {
            return "\(second)" + " " + "sec."
        } else {
            return "just now"
        }
    }
}
