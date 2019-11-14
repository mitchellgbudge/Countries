//
//  CountryController.swift
//  Countries-Solution
//
//  Created by Mitchell Budge on 11/14/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

let baseURL = URL(string: "https://restcountries.eu/rest/v2/")!

class CountryController: NSObject {
    
    @objc var countries: [Country] = []
    
    @objc(sharedController) static let shared = CountryController()
    
    typealias CompletionHandler = (Error?) -> Void
    
    @objc func fetchCountries(completion: @escaping ([Country]?, Error?) -> Void) {
        
        let allCountriesURL = baseURL.appendingPathComponent("all")
        URLSession.shared.dataTask(with: allCountriesURL) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                for dictionary in json as! [[String: Any]] {
                    guard let country = Country.init(dictionary: dictionary) else { return }
                    self.countries.append(country)
                    print(self.countries.count)
                }
            } catch {
                completion(nil, error)
                return
            }
            completion(self.countries, nil)
            }.resume()
    }
}
