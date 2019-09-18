//
//  ACUser.swift
//  ACTech
//
//  Created by mac on 9/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct ACUser: Codable {
    
    static var instance: ACUser? {
        didSet {
            guard let instance = instance else { return }
            _ = save(instance, byToken: instance.token!)
            UserDefaults.standard[.user] = instance
        }
    }
    
    let name: String?
    let surname: String?
    let email: String?
    let password: String?
    let token: String?
    let social: Bool?
    var settings: [ACSetting] = []
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case surname = "surname"
        case email = "email"
        case password = "password"
        case token = "token"
        case social = "social"
        case settings = "settings"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        surname = try values.decodeIfPresent(String.self, forKey: .surname)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        social = try values.decodeIfPresent(Bool.self, forKey: .social)
        settings = try values.decodeIfPresent([ACSetting].self, forKey: .settings) ?? []
    }
    
    init(name: String, surname: String, email: String, password: String, token: String, social: Bool, settings: [ACSetting] = []) {
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.token = token
        self.social = social
        self.settings = settings
    }
}


extension ACUser {

    static func save(_ user: ACUser?, byToken: String) -> ACUser? {
        
        guard let user = user else { return nil }
        
        let token = byToken
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: token)
            return user
        } else {
            return user
        }
    }
}
