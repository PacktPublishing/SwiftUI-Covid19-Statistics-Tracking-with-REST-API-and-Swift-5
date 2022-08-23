//
//  LocalFileManager.swift
//  CovidStats
//
//  Created by David Kababyan on 13/03/2022.
//

import Foundation

final class LocalFileManager {
    
    static let shared = LocalFileManager()
    
    private init () { }
    
    func saveCountriesLocally(countryData: Data?) {
        
        if let countryData = countryData {
            if let json = try? JSONSerialization.jsonObject(with: countryData, options: []) as? [String : Any] {
                
                do {
                    let fileURL = getDocumentDirectory().appendingPathComponent("country.json")
                    
                    try JSONSerialization.data(withJSONObject: json).write(to: fileURL)
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    func fetchLocalCountries() -> Data? {
        do {
            let fileURL = getDocumentDirectory().appendingPathComponent("country.json")

            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func getDocumentDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
