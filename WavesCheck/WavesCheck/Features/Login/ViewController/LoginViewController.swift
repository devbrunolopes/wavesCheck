//
//  LoginViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

class LoginViewController: UIViewController {

    var loginScreen: LoginScreen?
    
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = self.loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
