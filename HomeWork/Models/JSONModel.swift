//
//  JSONModel.swift
//  Navigation
//
//  Created by Слава Орлов on 14.04.2023.
//

import Foundation

struct NetworkModel {
    
    var userId: String
    var id: String
    var title: String
    var completed: String
    
}

struct PlanetInstance: Decodable {
    
    var name: String
    var rotation_period: String
    var orbital_period: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surface_water: String
    var population: String
    var residents: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: String
    
}
