//
//  TweetFeedTableViewController.swift
//  twitterClient
//
//  Created by AP Andrey Luferau on 12/23/19.
//  Copyright © 2019 AP Andrey Luferau. All rights reserved.
//

import UIKit
import OAuthSwift

class TweetFeedTableViewController: UITableViewController {

    let twitterManager = TwitterManager.instance

    @IBOutlet weak var refreshFeedButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        navigationItem.title = "Feed Page"
        
        twitterManager.testRequestForHomeTimeline()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @IBAction func refreshFeedAction(_ sender: Any) {
        tableView.reloadData()
    }

    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.setUserAuthorizedState(false)
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
        return TwitterManager.tweetsInfo.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = TwitterManager.tweetsInfo[indexPath.row].text
        return cell
    }

}
