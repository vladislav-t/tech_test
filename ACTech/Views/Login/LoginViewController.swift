//
//  LoginViewController.swift
//  ACTech
//
//  Created by mac on 9/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
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
    
    @IBOutlet weak var rememberSwitch: UISwitch! {
        didSet {
            rememberSwitch.transform = CGAffineTransform.init(scaleX: 0.85, y: 0.85)
        }
    }
    
    let loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc func swipeDown() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LoginViewController {
    @IBAction func didPressedSignInButton(_ sender: UIButton) {
        var acuser: ACUser?
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let defaults = UserDefaults.standard
        if defaults.value(forKey: email) == nil {
            presentAlertWithTitle(title: "Oppsss!", message: "Invalid credentials.", options: "ok") { (_) in }
            return
        } else {
            if let savedUser = defaults.object(forKey: email) as? Data {
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(ACUser.self, from: savedUser) {
                    acuser = user
                }
            }
        }
        
        ACUser.instance = acuser
        
        self.presentViewController(withStoryboardName: "Main", withIdentifier: "MainViewControllerNav")
    }
}

extension LoginViewController: UITextFieldDelegate {
    
}
