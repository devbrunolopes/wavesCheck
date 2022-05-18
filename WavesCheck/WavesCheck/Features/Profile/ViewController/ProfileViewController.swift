//
//  ProfileViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileScreen: ProfileScreen?
    
    override func loadView() {
        self.profileScreen = ProfileScreen()
        self.view = self.profileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
