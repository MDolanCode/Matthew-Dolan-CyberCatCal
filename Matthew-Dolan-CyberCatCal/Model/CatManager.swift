//
//  CatManager.swift
//  Matthew-Dolan-CyberCatCal
//
//  Created by Matt Dolan External macOS on 2021-07-09.
//

import Foundation

struct CatManager {
    
    var catArray = [String]()
    
    // Output -> String
    func getCatImage() {
        let urlString = "https://api.thecatapi.com/v1/images/search"
        
        guard let url = URL(string: urlString) else {
            print("Error in getting URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                if let catImage = self.parseJSON(safeData) {
                    print(catImage)
                }
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> String? {
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode([CatData].self, from: data)
            
            let catImage = decodeData.first?.url
            print(catImage!)
            return catImage
            
        } catch {
            print(error)
            return nil
        }
    }
}


