//
//  TweetFeedTableViewController.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/23/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import UIKit

class TweetFeedTableViewController: UITableViewController {

    //MARK: - variables

    let twitterManager = TwitterManager.instance
    private var twitterServerManager: TwitterServerManager!
    var alert = UIAlertController()

//    var tweets: [TweetInfo] {
//        return twitterManager.tweetsForTimeline()
//    }

    var tweets: [TweetInfo] = []

    //MARK: - IBOutlets

    @IBOutlet weak var refreshFeedButton: UIBarButtonItem!

    //MARK: - function for Loader

    private func startLoader() {
        if twitterServerManager.fetchingInProgress {
            alert = UIAlertController(title: nil, message: "Loading of tweets...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating()

            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
        }
    }

    private func stopLoader() {
        dismiss(animated: false, completion: nil)
    }

    //MARK: - Lifrcycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        navigationItem.title = "Feed Page"
        tableView.dataSource = self

        twitterServerManager = TwitterServerManager(delegate: self)

//        let lastId = tweets.last?.idStr

        request(count: 20)

//        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    func request(count: Int, lastId: String? = nil) {
        // show loader
        twitterServerManager.requestForHomeTimeline(count: 20, lastId: lastId, complition: { [weak self] result in
            // hide loader
            switch result {
            case .success(let tweets):
                if lastId == nil {
                    self?.tweets.removeAll()
                }
                self?.tweets.append(contentsOf: tweets)
                self?.tableView.reloadData()
            case .failure(let error):
                // show error
                break
            }
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        startLoader()
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(#function)
        return tweets.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = tweets[indexPath.row].text
//        cell.tweet = tweets[indexPath.row]
//        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let cell = cell as? TweetTableViewCell else { return }
        cell.configure(with: tweets[indexPath.row])

        if indexPath.row + 10 == tweets.count {
            request(count: 20, lastId: tweets.last?.idStr)
        }
    }
}

extension TweetFeedTableViewController: TwitterServerManagerDelegate {

    func onFetchCompleted() {

        if let _ = self.presentedViewController {
            stopLoader()
        }

        tableView.reloadData()
    }
    
}
