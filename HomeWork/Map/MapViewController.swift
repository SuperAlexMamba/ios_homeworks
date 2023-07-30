//
//  MapViewController.swift
//  Navigation
//
//  Created by Слава Орлов on 22.07.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let mapControllerView = MapControllerView.shared // View для контроллера
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapControllerView.locationManager.delegate = self
        mapControllerView.mapView.delegate = self
                
//        mapControllerView.locationManager.startUpdatingLocation() // обновление локации пользователя
                        
        setupView()
                
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        title = NSLocalizedString("map_title_key", comment: "")
        
        addSubviewsForMe() // добавление сабвью
                  
        setupConstraints() // настройка констрейнтов
                
        mapControllerView.addPin(title: "Hello!", lat: 59, lon: 0) // добавление пина
        
        mapControllerView.centerButton.addTarget(self, action: #selector(navigator), for: .touchUpInside)
        
        
    }
    
    @objc func navigator() {
        
        self.mapControllerView.navigate { alert in
            self.present(alert, animated: true)
        }
        
    }
        
    private func setupConstraints() {
        
        let standartButton = mapControllerView.standartTypeButton
        
        let satelliteButton = mapControllerView.satelliteTypeButton
        
        let centerButton = mapControllerView.centerButton
        
        let mapView = mapControllerView.mapView
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            
            satelliteButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 600),
            
            satelliteButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -50),
            
            standartButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 600),
            standartButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 50),
            
            centerButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 150),
            centerButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -150),
            centerButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 600)
        ])
    }
}

extension MapViewController {
    
    func addSubviewsForMe() {
        
        view.addSubview(mapControllerView.mapView)
        
        view.addSubview(mapControllerView.satelliteTypeButton)
        
        view.addSubview(mapControllerView.standartTypeButton)
        
        view.addSubview(mapControllerView.centerButton)
        
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //
    //        if let location = locations.first {
    //
    //            mapControllerView.setLocation(coordinate: location.coordinate) // при получении новой локации пользователя устанавливаем центр карты на координаты пользователя соответственно
    //
    //        }
    //    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let render = MKPolylineRenderer(overlay: overlay)
        
        render.strokeColor = .blue
        
        render.lineWidth = 6
        
        return render
    }
}
