//
//  RegisterViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerScreen: RegisterScreen?
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
