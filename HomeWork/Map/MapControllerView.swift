//
//  MapControllerView.swift
//  Navigation
//
//  Created by Слава Орлов on 24.07.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapControllerView {
    
    static let shared = MapControllerView()
    
    let locationManager = CLLocationManager()
    
    private init() {
        
        locationManager.requestWhenInUseAuthorization()
        
        satelliteTypeButton.addTarget(self, action: #selector(satelliteMap), for: .touchUpInside)
        
        standartTypeButton.addTarget(self, action: #selector(standartMap), for: .touchUpInside)
                
        mapView.showsUserLocation = true
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            print("Не определено")
        case .restricted:
            print("Рестриктед")
        case .denied:
            print("Отменено")
        case .authorizedAlways:
            print("Олвэйс")
        case .authorizedWhenInUse:
            print("При использовании")
        @unknown default:
            break
        }
        
    }
    
    lazy var mapView: MKMapView = {
        
        let map = MKMapView()
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
        map.region.center = .init(latitude: 59.9386, longitude: 30.3141)
        
        return map
    }()
    
    lazy var satelliteTypeButton: UIButton = {
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Satellite", for: .normal)
        
        button.backgroundColor = .gray
        
        button.layer.cornerRadius = 5
        
        button.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.5
        
        return button
    }()
    
    lazy var standartTypeButton: UIButton = {
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Standart", for: .normal)
        
        button.backgroundColor = .gray
        
        button.layer.cornerRadius = 5
        
        button.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.5
        
        return button
        
    }()
    
    lazy var centerButton: UIButton = {
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Маршрут", for: .normal)
        
        button.backgroundColor = .gray
        
        button.layer.cornerRadius = 5
        
        button.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.5
        
        return button
        
    }()
    
    
    @objc func satelliteMap() {
        self.mapView.mapType = .satellite
    }
    
    @objc func standartMap() {
        self.mapView.mapType = .standard
    }
    
    @objc func goToCenter() {
        self.mapView.setCenter(CLLocationCoordinate2D(latitude: 0, longitude: 0), animated: true)
    }
        
    func setLocation(coordinate: CLLocationCoordinate2D) {
        
        self.mapView.setCenter(coordinate, animated: true)
        
    }
    
    func addPin(title: String, lat: Double, lon: Double) {
        
        let annotation = MKPointAnnotation()
        
        annotation.title = title
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        mapView.addAnnotation(annotation)
        
    }
    
    func navigate(completion: (UIAlertController)->()) {
        
        let alertController = UIAlertController(title: "Здравствуйте!", message: "Введите пожалуйста город назначения!", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "город"
        }
        
        let okButton = UIAlertAction(title: "Старт", style: .default) { _ in
            
            if let city = alertController.textFields?.first?.text {
                
                self.getDirection(name: city)
                
            }
        }
        
        alertController.addAction(okButton)
        
        completion(alertController)
                        
    }
        
    func getDirection(name: String) {
                
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(name) { (placemarks, error) in
            
            if let error {
                
                print("Error! : \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first , let location = placemark.location else { return }
            
            let lat = location.coordinate.latitude
            
            let lon = location.coordinate.longitude
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            
            guard let sourceLocation = self.locationManager.location?.coordinate else { return }
                        
            let region = MKCoordinateRegion(center: sourceLocation, span: span)
            
            self.mapView.setRegion(region, animated: true)
            
            let request = MKDirections.Request()
            
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceLocation, addressDictionary: nil))
            
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), addressDictionary: nil))
            
            request.requestsAlternateRoutes = false
            
            request.transportType = .automobile
            
            let directions = MKDirections(request: request)
            directions.calculate { (response, error) in
                guard let route = response?.routes.first else {
                    if let error = error {
                        print("Ошибка при получении маршрута:", error.localizedDescription)
                    }
                    return
                }
                
                let overlays = self.mapView.overlays
                
                self.mapView.removeOverlays(overlays)
                                
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
            }
        }
    }
}
