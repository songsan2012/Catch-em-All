//
//  CreatureDetail.swift
//  Catch 'em All
//
//  Created by song on 3/10/22.
//

import Foundation

class CreatureDetail {
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprites
    }
    
    private struct Sprites: Codable {
        var front_default: String
    }
    
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    var urlString = ""
    
    
    func getData(completed: @escaping ()->()) {
        print("🕸 We are accessing the url \(urlString)")
        
        // create a url
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a url from \(urlString)")
            return
        }
        
        // create a session
        let session = URLSession.shared
        
        // get data with .dataTask method
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("😡 ERROR: Could not create a url from \(url). \(error.localizedDescription)")
            }
            
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                    print("😎 Here is what was returned \(returned)")
                self.height = returned.height
                self.weight = returned.weight
                self.imageURL = returned.sprites.front_default

            } catch {
                print("JSON ERROR: thrown when we tried to decode from Returned.self with data ")
            }
            completed()
        }
        
        task.resume()
    }
    
}
