//
//  ViewController.swift
//  ACTech
//
//  Created by mac on 9/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    let loginViewModel = LoginViewModel()
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.setTitle("Already have an account? Login", for: .normal)
            loginButton.underline(text: "Login")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let user = UserDefaults.standard[.user] {
            ACUser.instance = user
            DispatchQueue.main.async {
                self.presentViewController(withStoryboardName: "Main", withIdentifier: "MainViewControllerNav", animated: true)
            }
        }
    }
}

extension SignInViewController {
    
    @IBAction func didPressedContinueButton(_ sender: UIButton) {
        self.loginViewModel.facebookAuthorize { (error) in
            if let error = error {
                print("\(#function) error - \(error)")
                return
            }
            
            print("success")
        }
        
        self.presentViewController(withStoryboardName: "Main", withIdentifier: "MainViewControllerNav")
    }
    
    @IBAction func didPressedRegisterButton(_ sender: UIButton) {
        self.presentViewController(withStoryboardName: "Main", withIdentifier: "SignUpViewController")
    }
    
    @IBAction func didPressedLoginButton(_ sender: UIButton) {
        self.presentViewController(withStoryboardName: "Main", withIdentifier: "LoginViewController")
    }
    
    @IBAction func didPressedSoccialButton(_ sender: UIButton) {
        switch sender.tag {
        case LoginViewModel.LoginType.twitter.rawValue:
            self.loginViewModel.twitterAuthorize { (error) in
                if let error = error {
                    print("\(#function) error - \(error)")
                    return
                }
                
                print("success")
                self.presentViewController(withStoryboardName: "Main", withIdentifier: "MainViewControllerNav")
            }
            
        case LoginViewModel.LoginType.google.rawValue:
            self.loginViewModel.googleAuthorize { (error) in
                if let error = error {
                    print("\(#function) error - \(error)")
                    return
                }
                
                print("success")
                self.presentViewController(withStoryboardName: "Main", withIdentifier: "MainViewControllerNav")
            }
            
        case LoginViewModel.LoginType.apple.rawValue:
            self.loginViewModel.instagramAuthorize { (error) in
                if let error = error {
                    print("\(#function) error - \(error)")
                    return
                }
                
                print("success")
                self.presentViewController(withStoryboardName: "Main", withIdentifier: "MainViewControllerNav")
            }
            
        default:
            break
        }
    }
}

