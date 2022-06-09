//
//  ForecastViewController.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 16/05/22.
//

import UIKit
import MapKit
import CoreLocation

class MapsForecastViewController: UIViewController {
    
    var checkForecastScreen: MapsForecastScreen = MapsForecastScreen()
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
        checkForecastScreen = MapsForecastScreen()
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
        if checkForecastScreen.searchTextField.text == K.emptyString.rawValue {
            checkForecastScreen.navigateButton.isHidden = true
        }
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
            self.alert?.configAlert(title: K.Alerts.ops.rawValue, message: K.Alerts.locationExperience.rawValue, completion: nil)
        }
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            startTrackinUserLocation()
        case .denied:
            alert?.configAlert(title: K.Alerts.ops.rawValue, message: K.Alerts.locationExperience.rawValue, completion: nil)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            alert?.configAlert(title: K.Alerts.ops.rawValue, message: K.Alerts.locationExperience.rawValue, completion: nil)
        case . authorizedAlways:
            startTrackinUserLocation()
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
        geocoder.geocodeAddressString(checkForecastScreen.searchTextField.text ?? K.emptyString.rawValue) { placemarks, error in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                self.alert?.configAlert(title: K.Alerts.ops.rawValue, message: K.Alerts.noLocationFound.rawValue, completion: nil)
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
                if error != nil {
                    self.alert?.configAlert(title: K.Alerts.ops.rawValue, message: K.Alerts.noDirections.rawValue, completion: nil)
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
        let destination = checkForecastScreen.searchTextField.text ?? K.cupertino.rawValue
        guard let _destination = destination.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            //alert erro city name
            return
        }
        
        let url = K.URL.mapsApp.rawValue
        let mapsURL = "\(url)\(_destination)"
        if (UIApplication.shared.canOpenURL(URL(string: mapsURL)!)) {
          UIApplication.shared.openURL(URL(string: mapsURL)!)
        } else {
          //alert erro
        }
    }
}

//MARK: - MapViewProtocol

extension MapsForecastViewController: MapsForecastScreenProtocol {
    func selfLocationButtonAction() {
        startTrackinUserLocation()
    }
    
    func searchButtonAction() {
        getAddress()
        if checkForecastScreen.searchTextField.text != K.emptyString.rawValue {
            checkForecastScreen.navigateButton.isHidden = false
        }
    }
    
    func navigateButtonAction() {
        showMaps()
    }
}

//MARK: - NearLocationsTableViewCellProtocol

extension MapsForecastViewController: NearLocationsTableViewCellProtocol {
    func goButtonAction() {
        let vc: ForecastViewController = ForecastViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CLLocationManagerDelegate

extension MapsForecastViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        checkLocationAuthorization()
    }
}

//MARK: - MKMapViewDelegate

extension MapsForecastViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        return renderer
    }
}

//MARK: - TableView Delegate e DataSource

extension MapsForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        return K.bestSpots.rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
