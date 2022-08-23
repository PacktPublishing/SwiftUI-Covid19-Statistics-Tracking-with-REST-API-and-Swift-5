//
//  Region.swift
//  CovidStats
//
//  Created by David Kababyan on 12/03/2022.
//

import Foundation

struct AllRegions: Codable {
    let data: [Country]
}


struct Country: Codable {
    let iso: String
    let name: String
    
    static let dummyData = Country(iso: "N/A", name: "Error")
}
