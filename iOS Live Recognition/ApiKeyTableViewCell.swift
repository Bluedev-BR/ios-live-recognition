//
//  ApiKeyTableViewCell.swift
//  iOS Live Recognition
//
//  Created by Victor Shinya on 13/04/18.
//  Copyright © 2018 Victor Shinya. All rights reserved.
//

import UIKit

class ApiKeyTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    // MARK: - Global variables
    
    weak var delegate: ApiKeyTableViewCellDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var logoContainer: UIView!
    @IBOutlet weak var input: UITextField!

    // MARK: - Lifecycle events
    
    override func awakeFromNib() {
        super.awakeFromNib()
        input.delegate = self
        logoContainer.layer.cornerRadius = 5.0
        logoContainer.clipsToBounds = true
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didSaveAfterEditingAPIKey(self)
    }
}

// MARK: - ApiKeyTableViewCellDelegate protocol

protocol ApiKeyTableViewCellDelegate : class {
    func didSaveAfterEditingAPIKey(_ sender: ApiKeyTableViewCell)
}
