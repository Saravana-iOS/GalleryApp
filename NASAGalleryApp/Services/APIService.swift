//
//  APIService.swift
//  NASAGalleryApp
//
//  Created by Saravana kumar on 09/12/22.
//

import Foundation

class APIService : NSObject {
    
    private let sourceURL = URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json")
    
    func apiToGetImageData(completion : @escaping ([ImageModel]) -> ()){
        
        URLSession.shared.dataTask(with: sourceURL!) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                do {
                    let imgData = try jsonDecoder.decode([ImageModel].self, from: data)
                    completion(imgData)
                } catch {
                    // just ignore
                }
            }
            if let error = error {
                print(error)
            }
        }.resume()
    }
}
