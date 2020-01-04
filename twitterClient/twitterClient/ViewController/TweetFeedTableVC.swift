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

    let twitterManager = TwitterManager.instance
    var alert = UIAlertController()

    var tweets = [TweetInfo]()

    //MARK: - IBOutlets

    @IBOutlet weak var refreshFeedButton: UIBarButtonItem!

    //MARK: - function for Loader

    private func startLoader(message: String) {
            alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating()

            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
    }

    private func stopLoader() {
        dismiss(animated: false, completion: nil)
    }

    //MARK: - Lifrcycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        navigationItem.title = "Feed Page"

//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 600

        tableView.rowHeight = 300

//        let lastId = tweets.last?.idStr

        request(count: 20)
    }

    func request(count: Int, maxId: String? = nil) {
        startLoader(message: "Loading tweets...")
        twitterManager.getTweets(count: count, maxId: maxId, managerComplition: { [weak self] result in
            self?.stopLoader()
            switch result {
            case .success(let tweets):
                self?.tweets.append(contentsOf: tweets)
                self?.tableView.reloadData()

            case .failure(let error):
                print(error)
            }
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    //MARK: - IBActions
    
    @IBAction func refreshFeedAction(_ sender: Any) {
        tableView.reloadData()
    }

    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.cleanAuthorizationTokens()
        _ = navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

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

        cell.textTweetLabel.text = tweet.text
        cell.screenNameLabel.text = tweet.screenName
        cell.nameLabel.text = tweet.name
        cell.dateLabel.text = tweet.createdAt

        let url = URL(string: tweet.profileImageUrl)!
        cell.avatarImage.af_setImage(withURL: url)

        cell.selectionStyle = .none

        return cell

    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(#function)

//        guard let cell = cell as? TweetTableViewCell else { return }
//        cell.configure(with: tweets[indexPath.row])
//        if indexPath.row + 10 == tweets.count {
//            request(count: 20, lastId: tweets.last.idStr)
//        }
    }
}
