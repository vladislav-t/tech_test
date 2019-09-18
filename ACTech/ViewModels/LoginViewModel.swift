//
//  LoginViewModel.swift
//  ACTech
//
//  Created by mac on 9/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct LoginViewModel {
    
    enum LoginType: Int {
        case twitter = 0, google, apple
    }
    
    
    func googleAuthorize(completion: @escaping (_ error: String?) -> ()) {
        var user: ACUser?
        
        let token = "google"
        user = ACUser(name: token, surname: "surname_\(token)", email: "email_\(token)", password: token, token: token, social: true)
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: token) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(ACUser.self, from: savedData) {
                ACUser.instance = loadedUser
            } else {
                ACUser.instance = ACUser.save(user, byToken: token)
            }
        } else {
            ACUser.instance = ACUser.save(user, byToken: token)
        }
        
        completion(nil)
        return

    }
    
    func twitterAuthorize(completion: @escaping (_ error: String?) -> ()) {
        var user: ACUser?
        
        let token = "twitter"
        user = ACUser(name: token, surname: "surname_\(token)", email: "email_\(token)", password: token, token: token, social: true)
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: token) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(ACUser.self, from: savedData) {
                ACUser.instance = loadedUser
            } else {
                ACUser.instance = ACUser.save(user, byToken: token)
            }
        } else {
            ACUser.instance = ACUser.save(user, byToken: token)
        }
        
        completion(nil)
        return

    }
    
    func facebookAuthorize(completion: @escaping (_ error: String?) -> ()) {
        var user: ACUser?
        
        let token = "facebook"
        user = ACUser(name: token, surname: "surname_\(token)", email: "email_\(token)", password: token, token: token, social: true)
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: token) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(ACUser.self, from: savedData) {
                ACUser.instance = loadedUser
            } else {
                ACUser.instance = ACUser.save(user, byToken: token)
            }
        } else {
            ACUser.instance = ACUser.save(user, byToken: token)
        }
                
        completion(nil)
        return
     
    }
    
    func instagramAuthorize(completion: @escaping (_ error: String?) -> ()) {
        var user: ACUser?
        
        let token = "instagram"
        user = ACUser(name: token, surname: "surname_\(token)", email: "email_\(token)", password: token, token: token, social: true)
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: token) as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(ACUser.self, from: savedData) {
                ACUser.instance = loadedUser
            } else {
                ACUser.instance = ACUser.save(user, byToken: token)
            }
        } else {
            ACUser.instance = ACUser.save(user, byToken: token)
        }
        
        completion(nil)
        return
       
    }
    
}
