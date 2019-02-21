//
//  SignInViewController.swift
//  whatWasOrdered
//
//  Created by Yevhenii Orenchuk on 2/6/19.
//  Copyright © 2019 Yevhenii Orenchuk. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleAPIClientForREST

class SignInViewController: UIViewController {
    
    // MARK: Properties
    
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    private let service = GTLRSheetsService()
    
    private let signInButton = GIDSignInButton()
    
    // MARK: Outlets
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        signInButton.frame = CGRect(x: 0, y: 300, width: 300, height: 48)
        signInButton.center = view.center
        signInButton.style = GIDSignInButtonStyle.wide
        view.addSubview(signInButton)
    }
}

extension SignInViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            self.service.authorizer = nil
            let alert = UIAlertController(title: "Authentication Error", message: error.localizedDescription, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.signInButton.isHidden = true
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "userVC") as? UserSearchViewController
            if let vc = vc {
                vc.user = user
                vc.service = service
                present(vc, animated: false, completion: nil)
            } else {
                print("problem with init vc")
            }
        }
    }
}

