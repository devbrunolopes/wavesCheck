//
//  InfoViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 01/06/22.
//

import UIKit

class InfoViewController: UIViewController {

    var infoScreen: InfoScreen?
    
    override func loadView() {
        infoScreen = InfoScreen()
        view = infoScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoScreen?.delegate(delegate: self)
    }
}

extension InfoViewController: InfoViewDelegate {
    func backButtonAction() {
        dismiss(animated: true)
    }
}
