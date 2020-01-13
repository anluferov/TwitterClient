//
//  TweetTableViewCell.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 1/2/20.
//  Copyright © 2020 AP Andrey Luferau. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var textTweetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
//
//    func configure(with tweet: TweetInfo?) {
//        if let tweet = tweet {
//            textTweetLabel?.text = tweet.text
//        }
//    }

}
