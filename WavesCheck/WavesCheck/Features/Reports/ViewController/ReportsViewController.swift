//
//  ReportsViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit
import FirebaseFirestore
import FirebaseCoreInternal

class ReportsViewController: UIViewController {

    var reportsScreen: ReportsScreen?
//    var addReportsViewController: AddReportsViewController?
    let database = Firestore.firestore()
    
    var report: [Report] = []
    
    override func loadView() {
        reportsScreen = ReportsScreen()
        view = reportsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportsScreen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
}

extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return report.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportsTableViewCell.identifier) as? ReportsTableViewCell
        cell?.setUpCell(report: report[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
}

