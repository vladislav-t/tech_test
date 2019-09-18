//
//  ACSetting.swift
//  ACTech
//
//  Created by mac on 9/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit

struct ACSetting: Codable {
    
    var id: String? = Random.randomString(length: 12)
    var limit: CGFloat? = 1.0
    var number: String? = "\(Random.randomNumber())"
    var valid: String? = "2022"
    var owner: String? = "\(Random.randomString(length: Int.random(in: 3...7))) \(Random.randomString(length: Int.random(in: 3...7)))"
    var cvv: Int? = Random.randomNumber(length: 3)
    var active: Bool? = true

    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case limit = "limit"
        case number = "number"
        case valid = "valid"
        case owner = "owner"
        case cvv = "cvv"
        case active = "active"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        limit = try values.decodeIfPresent(CGFloat.self, forKey: .limit)
        number = try values.decodeIfPresent(String.self, forKey: .number)
        valid = try values.decodeIfPresent(String.self, forKey: .valid)
        owner = try values.decodeIfPresent(String.self, forKey: .owner)
        cvv = try values.decodeIfPresent(Int.self, forKey: .cvv)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
    }
    
    init() {
        
    }
}
