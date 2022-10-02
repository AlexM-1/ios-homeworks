//
//  NetworkService.swift
//  Navigation
//
//  Created by Alex M on 30.09.2022.
//

import Foundation

enum AppConfiguration: String {
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
}


class NetworkService {


    static func request(for configuration: AppConfiguration) {

        let strURL = configuration.rawValue

        if let url = URL(string: strURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    print ("✅ \(data)")
                }
                print ("➡️ \(response)")
                print ("❌ \(error)")
            }

            task.resume()
        }

    }

}
