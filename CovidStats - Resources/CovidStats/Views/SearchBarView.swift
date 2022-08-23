//
//  SearchBarView.swift
//  CovidStats
//
//  Created by David Kababyan on 12/03/2022.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Country...", text: $searchText)
                .foregroundColor(.white)
                .padding()
        }
        .frame(height: 50)
        .background(.regularMaterial)

    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
