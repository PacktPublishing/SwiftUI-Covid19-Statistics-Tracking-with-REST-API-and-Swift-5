//
//  MainView.swift
//  CovidStats
//
//  Created by David Kababyan on 12/03/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top) {
                
                LinearGradient(colors: [
                    Color(red: 0.76, green: 0.15, blue: 0.26),
                    Color(red: 0.01, green: 0.23, blue: 0.5)
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                
                VStack(alignment: .leading) {
                    
                    Text("World Total")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(10)
                    
                    TotalDataView(totalData: viewModel.totalData)
                    
                    if viewModel.isSearchVisible {
                        SearchBarView(searchText: $viewModel.searchText)
                    }
                    
                    Text("All countries")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(10)
                    
                    List {
                        Section {
                            ForEach(viewModel.allCountries.filter {
                                viewModel.searchText.isEmpty ? true : $0.name.lowercased().contains(viewModel.searchText.lowercased())
                            }, id: \.iso) { country in
                                
                                NavigationLink(destination: CountryDetailView(viewModel: CountryDetailViewModel(country: country))) {
                                    Text(country.name)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Statistics")
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            })
            .toolbar {
                Button {
                    viewModel.isSearchVisible.toggle()
                    if !viewModel.isSearchVisible {
                        viewModel.searchText = ""
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
            .tint(.white)
        }
        .accentColor(.primary)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
