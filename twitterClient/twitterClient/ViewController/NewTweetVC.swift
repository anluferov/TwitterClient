//
//  NewTweetVC.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 1/13/20.
//  Copyright © 2020 AP Andrey Luferau. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class NewTweetViewController: UIViewController {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    let twitterServerManager = TwitterServerManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setUserAvatar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tweetTextView.becomeFirstResponder()
        addTextViewPlaceholder()
        tweetTextView.delegate = self
    }

    fileprivate func addTextViewPlaceholder() {
        tweetTextView.text = "What's happening?"
        tweetTextView.textColor = UIColor.lightGray
        tweetTextView.selectedTextRange = tweetTextView.textRange(from: tweetTextView.beginningOfDocument, to: tweetTextView.beginningOfDocument)
    }
    
    @IBAction func createTweet(_ sender: Any) {

        if let text = tweetTextView.text {

            twitterServerManager.sendTweet(tweetText: text, serverComplition: { result in
                switch result {
                case .success(_):
                    self.navigationController?.popViewController(animated: true)
                    break
                case .failure(_):
                    break
                }
            })
        }
    }

    func setUserAvatar() {
        twitterServerManager.fetchUserImage(serverComplition: { result in
            switch result {
            case .success(let userInfo):
                let avatarProfileUrl = URL(string: userInfo.profileImageUrlHttps)!
                self.userAvatar.af_setImage(
                    withURL: avatarProfileUrl,
                    filter: CircleFilter()
                )

            case .failure(_):
                break
            }
        })
    }

}

extension NewTweetViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {

            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGray

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }

        // Else if the text view's placeholder is showing and the
        // length of the replacement string is greater than 0, set
        // the text color to black then set its text to the
        // replacement string
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }

        // For every other case, the text should change with the usual
        // behavior...
        else {
            return true
        }

        // ...otherwise return false since the updates have already
        // been made
        return false
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}
