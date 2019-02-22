//
//  UserSearchViewController.swift
//  whatWasOrdered
//
//  Created by Yevhenii Orenchuk on 2/19/19.
//  Copyright © 2019 Yevhenii Orenchuk. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST

class UserSearchViewController: UIViewController {
    
    // MARK: Properties
    
    var user: GIDGoogleUser?
    var service: GTLRSheetsService?
    private var usersList = [String]()
    var username = "" {
        willSet {
            usernameLabel.text = "Hi, " + newValue
        }
    }
    
    private var sheetFetcher: SpreadsheetValues!

    // MARK: Outlets
    
    @IBOutlet weak private var usernameLabel: UILabel!
    @IBOutlet weak private var infoLabel: UILabel!
    @IBOutlet weak private var usernameInput: UITextField!
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.isHidden = true
        usernameInput.isHidden = true
        usernameInput.delegate = self
        
        if let service = service {
            sheetFetcher = SpreadsheetValues(service: service)
        }
        
        if let name = user?.profile.name {
            username = name
        }
        
        fetchUsers(range: "Понедельник !A3:A43")
        checkUserExist(name: username, users: usersList)
    }
    
    private func fetchUsers(range: String) {
        sheetFetcher.fetchValues(range: range, majorDimension: "COLUMNS", complitionHandler: { result in
            if let users = result?.values?.first as? [String] {
                self.usersList = users
            }
        })
    }
    
    private func checkUserExist(name: String, users: [String]) {
        if users.contains(name) {
            print("All ok")
        } else {
            infoLabel.text = "There is no \(username) in the list, enter your name below"
            infoLabel.isHidden = false
            usernameInput.isHidden = false
        }
    }
}

extension UserSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        if text.isEmpty {
            return false
        }
        
        username = text
        infoLabel.isHidden = true
        
        checkUserExist(name: text, users: usersList)
        
        textField.resignFirstResponder()
        
        return true
    }
}


