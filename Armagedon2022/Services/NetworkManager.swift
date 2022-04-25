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

enum Link: String {
    case asteroidAPI = "https://api.nasa.gov/neo/rest/v1/feed?start_date=2022-04-25&end_date=2022-04-25&api_key=8BWMdmFWRW1Z97VocbBap33KHmhqxKAlqdpfnZ1o"
}

class NetworkManager: Codable {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, completion: @escaping (Asteroid) -> Void) {
        
        guard let url = URL(string: url ?? "") else { return }
        
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
