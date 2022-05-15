//
//  PasswordChangeViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 15/05/22.
//

import UIKit

class PasswordChangeViewController: UIViewController {

    var passwordChangeScreen: PasswordChangeScreen?
    
    override func loadView() {
        self.passwordChangeScreen = PasswordChangeScreen()
        self.view = self.passwordChangeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

