//
//  LoginViewController+Auth.swift
//  SpaceGallery
//
//  Created by Leonardo Domingues on 3/1/19.
//  Copyright © 2019 Leonardo Domingues. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController: LoginViewDelegate {
    
    func validateAccess(login: String, passw: String) -> Bool {
        if login == "admin" && passw == "admin" {
            let searchViewController = SearchViewController()
            self.present(searchViewController, animated: true, completion: nil)
            return true
        }
        return false
    }
    
    func resetAccess() {
        
    }
    
}
