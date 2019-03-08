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
    
    private func redirectTo(controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
    
    func validateAccess(login: String, passw: String, defaults: Bool) -> Bool {
        var credentials = ("loginUser", "passwUser")
        if defaults {
            credentials.0 = "loginAdmin"
            credentials.1 = "passwAdmin"
        }
        let loginDefaults = UserDefaults.standard.string(forKey: credentials.0)
        let passwDefaults = UserDefaults.standard.string(forKey: credentials.1)
        if login == loginDefaults && passw == passwDefaults {
            let navigationController = UINavigationController()
            let searchViewController = SearchViewController()
            navigationController.viewControllers = [searchViewController]
            redirectTo(controller: navigationController)
            return true
        }
        return false
    }
    
    func resetAccess() {
        let alert = UIAlertController(
            title: "Are you sure?",
            message: "User credencials will be erased.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "Yes",
            style: .default,
            handler: { _ in
                UserDefaults.standard.removeObject(forKey: "loginUser")
                UserDefaults.standard.removeObject(forKey: "passwUser")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func signUp() {
        let signUpViewController = SignUpViewController()
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(
            name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(signUpViewController, animated: false, completion: nil)
    }
    
}
