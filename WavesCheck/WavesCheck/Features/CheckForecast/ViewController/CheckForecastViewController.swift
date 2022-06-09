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
    
    var checkForecastScreen: CheckForecastScreen = CheckForecastScreen()
    let locationManager = CLLocationManager()
    var alert: Alert?
    var previousLocation: CLLocation?
    var directionsArray: [MKDirections] = []
    var coordinateAddress: CLLocationCoordinate2D?
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
        checkForecastScreen.configTableViewProtocols(delegate: self, dataSource: self)
        checkForecastScreen.delegate(delegate: self)
        checkLocationServices()
        alert = Alert(controller: self)
        checkForecastScreen.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkForecastScreen.navigateButton.isHidden = true
    }

//MARK: - Maps Management

    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            checkForecastScreen.mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            checkLocationAuthorization()
        } else {
            self.alert?.configAlert(title: "Ops", message: "Para uma experiência melhor, autorizar o uso da sua localização!", completion: nil)
        }
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            startTrackinUserLocation()
            break
        case .denied:
            //show alert ensinar dar permnissao
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //show alert
            break
        case . authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func startTrackinUserLocation() {
        checkForecastScreen.mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: checkForecastScreen.mapView)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func getAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(checkForecastScreen.searchTextField.text ?? "") { placemarks, error in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                self.alert?.configAlert(title: "Ops", message: "Não encontramos nenhuma localização :(", completion: nil)
                return
            }
            self.createDirections(destination: location.coordinate)
        }
    }
    
    func createDirections(destination: CLLocationCoordinate2D) {
        let sourceCoordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D()
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        getDistance(startLocation: sourceCoordinate, destinationLocation: destination)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destinationItem
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        removePins()
        
        let destinationPin = MKPointAnnotation()
        if let location = destinationPlacemark.location {
            destinationPin.coordinate = location.coordinate
            checkForecastScreen.mapView.showAnnotations([destinationPin], animated: true)
        }
        
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        directions.calculate { response , error in
            guard let response = response else {
                if let error = error {
                    //alert erro
                }
                return
            }
            for route in response.routes {
                self.checkForecastScreen.mapView.addOverlay(route.polyline)
                self.checkForecastScreen.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func getDistance(startLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D) {
        let loc1 = CLLocation(latitude: startLocation.latitude, longitude: startLocation.longitude)
        let loc2 = CLLocation(latitude: destinationLocation.latitude, longitude: destinationLocation.longitude)
        let distance = loc1.distance(from: loc2)
        print(distance)
    }
    
    func removePins() {
        for pin in checkForecastScreen.mapView.annotations {
            checkForecastScreen.mapView.removeAnnotation(pin)
        }
    }
    
    func resetMapView(withNew directions: MKDirections) {
        checkForecastScreen.mapView.removeOverlays(checkForecastScreen.mapView.overlays)
        directionsArray.append(directions)
        let _ = directionsArray.map { $0.cancel() }
    }
    
    func showMaps() {
        let destination = checkForecastScreen.searchTextField.text ?? "cupertino"
        guard let _destination = destination.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            //alert erro city name
            return
        }
        
        let url = "http://maps.apple.com/?q="
        let mapsURL = "\(url)\(_destination)"
        if (UIApplication.shared.canOpenURL(URL(string: mapsURL)!)) {
          UIApplication.shared.openURL(URL(string: mapsURL)!)
        } else {
          //alert erro
        }
    }
}

//MARK: - MapViewProtocol

extension CheckForecastViewController: CheckForecastScreenProtocol {
    func selfLocationButtonAction() {
    }
    
    func searchButtonAction() {
        getAddress()
        checkForecastScreen.navigateButton.isHidden = false
    }
    
    func navigateButtonAction() {
        //alert avisando que vai sair do app
        showMaps()
    }
}

//MARK: - NearLocationsTableViewCellProtocol

extension CheckForecastViewController: NearLocationsTableViewCellProtocol {
    func goButtonAction() {
        let vc: ForecastViewController = ForecastViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CLLocationManagerDelegate

extension CheckForecastViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        checkLocationAuthorization()
    }
}

//MARK: - MKMapViewDelegate

extension CheckForecastViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        return renderer
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
