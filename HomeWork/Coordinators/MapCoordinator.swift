//
//  MapCoordinator.swift
//  Navigation
//
//  Created by Слава Орлов on 22.07.2023.
//

import UIKit

class MapCoordinator: Coordinator {
    
    var rootController = UINavigationController()
    
    init() {
        self.rootController = UINavigationController()
    }
    
    lazy var mapController = {
       
        let vc = MapViewController()
        
        return vc
    }()
    
    func start() {
        
        self.rootController.setViewControllers([mapController], animated: true)
        
    }

}
