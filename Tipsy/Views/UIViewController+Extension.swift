//
//  UIViewController+Extension.swift
//  Tipsy
//
//  Created by Ubonvan Chuenkamon on 4/27/20.
//

import Foundation
import UIKit

extension UIViewController {
    func instantiateViewController<T : UIViewController> (_ typeClass : T.Type) throws -> T {
        guard let storyboard = self.storyboard else {
            return try instantiateViewControllerFromMain(typeClass)
        }
        guard let controller : T = storyboard.instantiateViewController(withIdentifier: String(describing: typeClass.self)) as? T else {
            throw NSError(domain: "UIViewController.extension", code: 102, userInfo: ["function": "instantiateViewController",
            "parameter" : String(describing: typeClass.self)])
        }
        return controller
    }
    
    func instantiateViewControllerFromMain<T : UIViewController>(_ typeClass : T.Type) throws -> T {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        
        guard let controller : T = storyboard.instantiateViewController(withIdentifier: String(describing: typeClass.self)) as? T else {
            throw NSError(domain: "UIViewController.extension", code: 101, userInfo: ["function": "instantiateViewControllerFromMain",
                "parameter" : String(describing: typeClass.self)])
        }
        return controller
    }
}
