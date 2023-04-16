//
//  NetworkService.swift
//  Navigation
//
//  Created by Слава Орлов on 14.04.2023.
//

import Foundation

struct NetworkSerialization {

    static func request( completion: ((_ period: String) -> Void)? ) {

        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/2")

        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in

            if let error {
                print(error.localizedDescription)
                return
            }

            guard let HTTPResponse = response as? HTTPURLResponse else {
                print("Error when getting response")
                return
            }

            if !( (200..<300).contains(HTTPResponse.statusCode)) {
                print("Error status code - \(HTTPResponse.statusCode)")
            }

            guard let data else { return }

            // parsing data

            do {
                guard let answer = try JSONSerialization.jsonObject(with: data) as? [String : Any] else {
                    print("Error parsing data! Answer not cast to string any")
                    return
                }
                guard let title = answer["title"] as? String else { return }
                completion?(title)

            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}

struct NetworkServiceWitchDecoder {
    
    static func request(completion: ((_ name: String) -> Void)?) {
        
        let url = URL(string: "https://swapi.dev/api/planets/1")
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if let error {
                print("Error \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error when getting response")
                return
            }
            
            if !((200..<300).contains(httpResponse.statusCode)) {
                print("Error status code - \(httpResponse.statusCode)")
                return
            }
            
            guard let data else { return }
            
            // parsing data
            
            do {
                let answer = try JSONDecoder().decode(PlanetInstance.self, from: data)
                completion?(answer.orbital_period)
            }
            
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
