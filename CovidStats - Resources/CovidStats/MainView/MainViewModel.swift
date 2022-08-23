//
//  MainViewModel.swift
//  CovidStats
//
//  Created by David Kababyan on 12/03/2022.
//

import Foundation

final class MainViewModel: ObservableObject {
    
    @Published var totalData = TotalData.dummyData
    @Published var allCountries: [Country] = []
    @Published var searchText = ""
    @Published var isSearchVisible = false
    @Published var alertItem: AlertItem?
    
    init() {
        fetchTotalData()
        fetchAllCountries()
    }
    
    func fetchTotalData() {
        APIService.shared.fetchTotalData { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let totalData):
                    self.totalData = totalData
                case .failure(_):
                    self.alertItem = AlertContext.unableToFetchTotalStats
                }
            }
        }
    }
    
    func fetchAllCountries() {
        APIService.shared.fetchAllRegions { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let allCountries):
                    self.allCountries = allCountries.sorted(by: { $0.name < $1.name })
                case .failure(_):
                    self.alertItem = AlertContext.unableToFetchCountries
                }
            }
        }
    }
}
