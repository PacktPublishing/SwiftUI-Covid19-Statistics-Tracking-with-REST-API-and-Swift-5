//
//  APIService.swift
//  CovidStats
//
//  Created by David Kababyan on 12/03/2022.
//

import Foundation

final class APIService {
    
    static let shared = APIService()
    
    private init () { }
    
    private let headers = [
        "x-rapidapi-host": "covid-19-statistics.p.rapidapi.com",
        "x-rapidapi-key": "d172e810e7msh47584ae043c146dp12d8eejsnb0b3c42c4a59"
    ]

    private let baseURLString = "https://covid-19-statistics.p.rapidapi.com"
    
    
    
    func fetchTotalData(completion: @escaping (Result<TotalData, Error>) -> Void) {
        
        let totalURLString = baseURLString + "/reports/total"

        let url = URL(string: totalURLString)
        
        guard let url = url else {
            completion(.failure(CovidError.incorrectURL))
            return
        }

        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                completion(.failure(CovidError.noDataReceived))
            } else {
                
//                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    print(json)
//                }
                
                let decoder = JSONDecoder()
                
                do {
                    let totalDataObject = try decoder.decode(TotalDataObject.self, from: data!)
                    completion(.success(totalDataObject.data))
                } catch let error {
                    completion(.failure(error))
                }
            }
        })

        dataTask.resume()
    }
    
    
    
    func fetchAllRegions(completion: @escaping (Result<[Country], Error>) -> Void) {
        
        let decoder = JSONDecoder()

        //check if local data is available
        if let data = LocalFileManager.shared.fetchLocalCountries() {
            do {
                let allCountries = try decoder.decode(AllRegions.self, from: data)
                completion(.success(allCountries.data))
            } catch let error {
                completion(.failure(error))
            }
            return
        }
        
        
        let countriesURLString = baseURLString + "/regions"

        let url = URL(string: countriesURLString)
        
        guard let url = url else {
            completion(.failure(CovidError.incorrectURL))
            return
        }

        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                completion(.failure(CovidError.noDataReceived))
            } else {
                
//                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    print(json)
//                }
                //save locally
                LocalFileManager.shared.saveCountriesLocally(countryData: data)
                
                do {
                    let allCountries = try decoder.decode(AllRegions.self, from: data!)
                    completion(.success(allCountries.data))
                } catch let error {
                    completion(.failure(error))
                }
            }
        })

        dataTask.resume()
    }
    
    
    
    func fetchReport(for iso: String, completion: @escaping (Result<[RegionReport], Error>) -> Void) {
        
        let reportsURLString = baseURLString + "/reports?iso=\(iso)"

        let url = URL(string: reportsURLString)
        
        guard let url = url else {
            completion(.failure(CovidError.incorrectURL))
            return
        }

        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                completion(.failure(CovidError.noDataReceived))
            } else {
                
//                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    print(json)
//                }

                let decoder = JSONDecoder()
                
                let formatter = DateFormatter()
                formatter.dateFormat = "y-MM-dd"
                decoder.dateDecodingStrategy = .formatted(formatter)
                
                do {
                    let allReports = try decoder.decode(AllReports.self, from: data!)
                    completion(.success(allReports.data))
                } catch let error {
                    completion(.failure(error))
                }
            }
        })

        dataTask.resume()
    }

}
