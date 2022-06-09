//
//  ReportsViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseCoreInternal

class ReportsViewController: UIViewController {

    var reportsScreen: ReportsScreen?
    var addReportsViewController: AddReportsViewController?
    let database = Firestore.firestore()
    var reports: [Report] = []
    
    override func loadView() {
        reportsScreen = ReportsScreen()
        view = reportsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportsScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        reportsScreen?.delegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData() {
        database.collection("reports").order(by: "reportDate", descending: true).getDocuments { snapshot, error in
            
            if error == nil {
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        self.reports = snapshot.documents.map { document in
                            return Report(id: document.documentID,
                                          nameLocation: document["nameLocation"] as? String ?? "",
                                          wavesSize: document["wavesSize"] as? String ?? "",
                                          surfCondition: document["surfCondition"] as? String ?? "",
                                          surfImage: document["surfImage"] as? String ?? "")
                        }
                        self.reportsScreen?.tableView.reloadData()
                    }
                }
                
            } else {
                //handle errors
            }
        }
    }
}
//MARK: - ReportsScreenProtocol

extension ReportsViewController: ReportsScreenProtocol {
    func addReportAction() {
        let vc: AddReportsViewController = AddReportsViewController()
        present(vc, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportsTableViewCell.identifier) as? ReportsTableViewCell
        cell?.setUpCell(report: reports[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
}
