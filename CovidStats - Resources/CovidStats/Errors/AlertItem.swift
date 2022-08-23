//
//  AlertItem.swift
//  CovidStats
//
//  Created by David Kababyan on 13/03/2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}


struct AlertContext {
    
    static let unableToFetchTotalStats = AlertItem(title: Text("Error World Total!"), message: Text("Server doesn't respond \n Please try again later."), dismissButton: .default(Text("OK")))
    
    static let unableToFetchCountryStats = AlertItem(title: Text("Error Country Data!"), message: Text("Unable to receive data from the server \n Please try again later."), dismissButton: .default(Text("OK")))

    static let unableToFetchCountries  = AlertItem(title: Text("Server Error!"), message: Text("Unable to fetch list of countries. \n Please try again later."), dismissButton: .default(Text("OK")))

}
