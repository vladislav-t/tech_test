//
//  SignUpViewController.swift
//  ACTech
//
//  Created by mac on 9/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let loginViewModel = LoginViewModel()
    
    @IBOutlet weak var termsSwitch: UISwitch! {
        didSet {
            termsSwitch.transform = CGAffineTransform.init(scaleX: 0.85, y: 0.85)
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc func swipeDown() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpViewController {
    @IBAction func didPressedSignUpButton(_ sender: UIButton) {
        var user: ACUser?
        
        guard let name = nameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        let token = email
        user = ACUser(name: name, surname: "surname", email: email, password: password, token: token, social: true)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            if defaults.value(forKey: token) == nil {
                defaults.set(encoded, forKey: token)
            }
        }
        
        ACUser.instance = user
        
        self.presentViewController(withStoryboardName: "Main", withIdentifier: "MainViewControllerNav")
    }
}

extension SignUpViewController {
    
    @IBAction func didPressedSoccialButton(_ sender: UIButton) {
        switch sender.tag {
        case LoginViewModel.LoginType.twitter.rawValue:
            self.loginViewModel.twitterAuthorize { (error) in
                if let error = error {
                    print("\(#function) error - \(error)")
                    return
                }
                
                print("success")
            }
            self.presentViewController(withStoryboardName: "Main", withIdentifier: "MainViewControllerNav")

            
        case LoginViewModel.LoginType.google.rawValue:
            self.loginViewModel.googleAuthorize { (error) in
                if let error = error {
                    print("\(#function) error - \(error)")
                    return
                }
                
                print("success")
            }
            self.presentViewController(withStoryboardName: "Main", withIdentifier: "MainViewControllerNav")

            
        case LoginViewModel.LoginType.apple.rawValue:
            self.loginViewModel.instagramAuthorize { (error) in
                if let error = error {
                    print("\(#function) error - \(error)")
                    return
                }
                
                print("success")
            }
            self.presentViewController(withStoryboardName: "Main", withIdentifier: "MainViewControllerNav")

            
        default:
            break
        }
    }
}



extension SignUpViewController: UITextFieldDelegate {
    
}
