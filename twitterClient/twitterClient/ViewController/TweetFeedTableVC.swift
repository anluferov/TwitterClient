//
//  TweetFeedTableViewController.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/23/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetFeedTableViewController: UITableViewController {

    //MARK: - variables

    let twitterManager = TwitterManager()
    var tweets = [TweetInfo]()

    @IBOutlet weak var refreshFeedButton: UIBarButtonItem!
    var alert = UIAlertController()

    var isFetchingInProgress = false

    //MARK: - VC Lifecycle functions

    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        navigationItem.title = "Feed Page"

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200

        addCreateTweetButton()

        requestForTweets(count: 20)
    }

    override func viewDidAppear(_ animated: Bool) {
        print(#function)
        super.viewDidAppear(animated)

        if isFetchingInProgress {
            startFetchingTweetsLoader(message: "Loading tweets...")
        }
    }

    //MARK: - IBActions
    
    @IBAction func refreshFeedAction(_ sender: Any) {
        tableView.reloadData()
    }

    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.cleanAuthorizationTokens()
        _ = navigationController?.popViewController(animated: true)
    }

    //MARK: - createNewTweet button

    func addCreateTweetButton() {
        let createTweetButton = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width * 3/4, y: self.view.frame.height * 5/6),
                                                size: CGSize(width: 50.0, height: 50.0)))
//        createTweetButton.backgroundColor = .blue
        self.navigationController?.view.addSubview(createTweetButton)
        createTweetButton.setImage(UIImage(named: "plusButton"), for: .normal)
    }
    

    //MARK: - function for Alerts

    private func startFetchingTweetsLoader(message: String) {
        alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }

    private func stopFetchingTweetsLoader() {
        dismiss(animated: false, completion: nil)
    }

    private func presentErrorAlert(message: String) {
        alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertButton)

        present(alert, animated: true, completion: nil)
    }

    // MARK: - TableView data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TweetTableViewCell
        let tweet = tweets[indexPath.row]

        //fill tweet text
        cell.textTweetLabel.text = tweet.fullText

        //fill username
        cell.screenNameLabel.text = " @" + tweet.screenName

        //fill name of account
        cell.nameLabel.text = tweet.name

        //fill avatar
        let avatarUrl = URL(string: tweet.profileImageUrl)!
        cell.avatarImage.af_setImage(
            withURL: avatarUrl,
            filter: CircleFilter()
        )

        //fill date ago for tweet
        cell.dateLabel.text = tweet.createdAt.getTimeAgoFormat()

        cell.selectionStyle = .none

        return cell

    }

//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//      return UITableView.automaticDimension
//    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(#function)

//        guard let cell = cell as? TweetTableViewCell else { return }
//        cell.configure(with: tweets[indexPath.row])

//        Subtract 1 from the lowest Tweet ID returned from the previous request and use this for the value of max_id.
//        https://developer.twitter.com/en/docs/tweets/timelines/guides/working-with-timelines

        if indexPath.row + 10 == tweets.count {
            if let lastTweet = tweets.last, let maxIdInt = Int(lastTweet.idStr) {
                let maxIdString = String(maxIdInt - 1)
                requestForTweets(count: 20, maxId: maxIdString)
            }
        }
    }

    //MARK: - work with tweets data

    func requestForTweets(count: Int, maxId: String? = nil) {
        isFetchingInProgress = true
        twitterManager.getTweets(count: count, maxId: maxId, managerComplition: { [weak self] result in
            switch result {
            case .success(let tweets):
                self?.isFetchingInProgress = false
                self?.stopFetchingTweetsLoader()
                self?.tweets.append(contentsOf: tweets)
                self?.tableView.reloadData()

            case .failure(let error):
                print(error)
                self?.isFetchingInProgress = false
                self?.stopFetchingTweetsLoader()
                self?.presentErrorAlert(message: error.localizedDescription)
            }
        })
    }
}
