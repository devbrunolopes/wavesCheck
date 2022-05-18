//
//  FavoriteSpotsViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit

class FavoriteSpotsViewController: UIViewController {

    var favoriteScreen: FavoriteSpotsScreen?
    
    var favoritePlaces: [LocationName] = [
        LocationName(locationName: "Praia da Macumba"), LocationName(locationName: "Canto do Recreio"), LocationName(locationName: "Prainha"), LocationName(locationName: "Grumari"), LocationName(locationName: "Praia do Tombo"), LocationName(locationName: "Canto do Forte"), LocationName(locationName: "Monduba"), LocationName(locationName: "El Sunzal"), LocationName(locationName: "Lobitos"), LocationName(locationName: "Saquarema"), LocationName(locationName: "Trestles"), LocationName(locationName: "Teahupoo"), LocationName(locationName: "Fiji"), LocationName(locationName: "La Bocana"), LocationName(locationName: "Punta Mango")
    ]
    
    override func loadView() {
        favoriteScreen = FavoriteSpotsScreen()
        view = favoriteScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteScreen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
}

extension FavoriteSpotsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteSpotsTableViewCell.identifier) as? FavoriteSpotsTableViewCell
        cell?.setUpCell(locationName: favoritePlaces[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
