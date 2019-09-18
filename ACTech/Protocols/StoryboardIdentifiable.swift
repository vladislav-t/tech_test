//
//  StoryboardIdentifiable.swift
//  ACTech
//
//  Created by mac on 9/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }

extension UIStoryboard {
    enum Storyboard: String {
        
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(_ storyboard: Storyboard) {
        self.init(name: storyboard.filename, bundle: Bundle.main)
    }
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}

extension UIViewController {
    func presentViewController(withStoryboardName storyboard: String, withIdentifier identifier: String? = nil, animated: Bool = true) {
        let sb = UIStoryboard(name: storyboard, bundle: Bundle.main)
        var viewController: UIViewController?
        if identifier != nil {
            let vc = sb.instantiateViewController(withIdentifier: identifier!)
            viewController = vc
        }else {
            if let initial = sb.instantiateInitialViewController(){
                viewController = initial
            }
        }
        
        if viewController != nil {
            present(viewController!, animated: animated, completion: nil)
        }
    }
}
