//
//  NetworkManager.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 25.04.2022.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidUrl
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    var requestDay = Date()
    var correctRequestDay: String {
        requestDay.getCorrectDate("yyyy-MM-dd")
    }
    
    private init() {}
    
    func fetchData(completion: @escaping (Asteroid) -> Void) {
        
        let asteroidAPI = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(correctRequestDay)&end_date=\(correctRequestDay)&api_key=8BWMdmFWRW1Z97VocbBap33KHmhqxKAlqdpfnZ1o"
        
        guard let url = URL(string: asteroidAPI) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description error")
                return
            }
            
            do {
                let asteroidData = try JSONDecoder().decode(Asteroid.self, from: data)
                DispatchQueue.main.async {
                    completion(asteroidData)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
