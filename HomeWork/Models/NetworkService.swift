//
//  NetworkService.swift
//  Navigation
//
//  Created by Слава Орлов on 14.04.2023.
//

import Foundation

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        
        var address = URL(string: "")
        
        switch configuration {
            
        case .firstURL(let url):
            address = URL(string: url)
        case .secondURL(let url):
            address = URL(string: url)
        case .thirdURL(let url):
            address = URL(string: url)
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: address!) { data, response, error in
            
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error when getting response")
                return
            }
            
            if !((200..<300).contains(httpResponse.statusCode)) {
                print("Error, status code = \(httpResponse.statusCode)")
                
            }
            
            guard let data else {
                return
            }
            
            print("data = \(data) , statusCode = \(httpResponse.statusCode) , allHeaderFields = \(httpResponse.allHeaderFields)")
                
            
            // Код 1009 При выключенном интернете
        }
        task.resume()
    }
}

enum AppConfiguration {
    case firstURL(
        url: String)
    case secondURL(
        url: String)
    case thirdURL(
        url: String)
}
