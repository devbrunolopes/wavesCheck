//
//  ForecastViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit
import MapKit
import CoreLocation

class CheckForecastViewController: UIViewController {
    
    let manager = CLLocationManager()
    var checkForecastScreen: CheckForecastScreen?
    
    var nearLocation: [NearLocation] = [
        NearLocation(locationName: "Praia da Macumba"),
        NearLocation(locationName: "Canto do Recreio"),
        NearLocation(locationName: "Prainha")
    ]
    
    override func loadView() {
        checkForecastScreen = CheckForecastScreen()
        view = checkForecastScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForecastScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        checkForecastScreen?.delegate(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
}

//MARK: - NearLocationsTableViewCellProtocol

extension CheckForecastViewController: NearLocationsTableViewCellProtocol {
    func goButtonAction() {
        print(#function)
        let vc: ForecastViewController = ForecastViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CheckForecastScreenProtocol

extension CheckForecastViewController: CheckForecastScreenProtocol {
    func selfLocationButtonAction() {
    }
    
    func searchButtonAction() {
        guard let address = checkForecastScreen?.searchTextField.text else { return }
        
        getCoordinateFrom(address: address) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            
            DispatchQueue.main.async {
                let lat = coordinate.latitude
                let lng = coordinate.longitude
                print("\(lat), \(lng)")
            }
        }
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}

//MARK: - CLLocationManagerDelegate

extension CheckForecastViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    private func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1,
                                    longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate,
                                        span: span)
        
        checkForecastScreen?.mapView.setRegion(region,
                           animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        checkForecastScreen?.mapView.addAnnotation(pin)
    }
}

//MARK: - TableView Delegate e DataSource

extension CheckForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nearLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NearLocationsTableViewCell.identifier, for: indexPath) as? NearLocationsTableViewCell
        cell?.setUpCell(nearLocation: self.nearLocation[indexPath.row])
        cell?.delegate(delegate: self)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Locais próximos"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
