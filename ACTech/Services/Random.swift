//
//  Random.swift
//  ACTech
//
//  Created by mac on 9/18/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class Random {
    
    class func randomString(length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    class func randomNumber(length: Int = 16) -> Int {
        let letters = "0123456789"
        return Int(String((0..<length).map{ _ in letters.randomElement()! }))!
    }
}
