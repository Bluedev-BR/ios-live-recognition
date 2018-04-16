//
//  SettingTableViewController.swift
//  iOS Live Recognition
//
//  Created by Victor Shinya on 13/04/18.
//  Copyright © 2018 Victor Shinya. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController, ApiKeyTableViewCellDelegate {
    
    // MARK: - Global variables
    
    let cellIdentifier = "ApiKeyCell"

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ApiKeyTableViewCell else {
            fatalError("The dequeued cell is not an instance of ApiKeyCell")
        }
        cell.delegate = self
        if let apiKey = UserDefaults.standard.value(forKey: Constants.key) as? String {
            cell.input.text = apiKey
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Visual Recognition"
    }
    
    // MARK: - ApiKeyTableViewCellDelegate
    
    func didSaveAfterEditingAPIKey(_ sender: ApiKeyTableViewCell) {
        let apiKey = sender.input.text
        let defaults = UserDefaults.standard
        defaults.setValue(apiKey, forKey: Constants.key)
    }
}
