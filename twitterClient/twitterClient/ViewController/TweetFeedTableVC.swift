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
    let alert = UIAlertController(title: nil, message: "Loading of tweets...", preferredStyle: .alert)

//    var tweets: [TweetInfo] {
//        return twitterManager.tweetsForTimeline()
//    }

    var tweets: [TweetInfo] {
        return twitterServerManager.tweetsArray
    }

    //MARK: - IBOutlets

    @IBOutlet weak var refreshFeedButton: UIBarButtonItem!

    //MARK: - function for Loader

    private func startLoader() {
        if twitterServerManager.fetchingInProgress {
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

        twitterServerManager = TwitterServerManager(delegate: self)
        twitterServerManager.requestForHomeTimeline()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tweets[indexPath.row].text
        return cell
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
