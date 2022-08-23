//
//  CountryDetailViewModel.swift
//  CovidStats
//
//  Created by David Kababyan on 12/03/2022.
//

import Foundation

final class CountryDetailViewModel: ObservableObject {
    
    @Published var reports: [RegionReport] = []
    @Published var alertItem: AlertItem?
    
    private var iso: String
    
    init(country: Country) {
        iso = country.iso
    }
    
    func fetchReport() {
        
        APIService.shared.fetchReport(for: iso) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let reports):
                    self.reports = reports
                case .failure(_):
                    self.alertItem = AlertContext.unableToFetchCountryStats
                }
            }
        }
    }
}
