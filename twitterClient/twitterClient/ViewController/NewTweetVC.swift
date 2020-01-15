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

    //MARK: - variables
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    let twitterServerManager = TwitterServerManager.shared

    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserAvatar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tweetTextView.becomeFirstResponder()
        addTextViewPlaceholder()
        tweetButton.isEnabled = false

        tweetTextView.delegate = self
    }

    //MARK: - IBAction
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

    //MARK: - configure of VC default state function
    fileprivate func addTextViewPlaceholder() {
        tweetTextView.text = "What's happening?"
        tweetTextView.textColor = UIColor.lightGray
        tweetTextView.selectedTextRange = tweetTextView.textRange(from: tweetTextView.beginningOfDocument, to: tweetTextView.beginningOfDocument)
    }

    func setUserAvatar() {
        twitterServerManager.fetchUserImage(serverComplition: { result in
            switch result {
            case .success(let userInfo):
                let avatarProfileUrl = URL(string: userInfo.profileImageUrlHttps)!
                let placeholderImage = UIImage(named: "placeholderImage")!
                self.userAvatar.af_setImage(
                    withURL: avatarProfileUrl,
                    placeholderImage: placeholderImage,
                    filter: CircleFilter()
                )

            case .failure(_):
                break
            }
        })
    }

}

//MARK: - UITextViewDelegate
extension NewTweetViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        if updatedText.isEmpty {
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            tweetButton.isEnabled = false
        } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
            tweetButton.isEnabled = true
        } else {
            return textView.text.count <= 280
        }

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
