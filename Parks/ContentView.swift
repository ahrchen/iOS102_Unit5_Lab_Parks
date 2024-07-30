//
//  ContentView.swift
//  Parks
//
//  Created by Raymond Chen on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var parks: [Park] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(parks) { park in
                        NavigationLink(value: park) {
                            ParkRow(park: park)
                        }
                    }
                }
            }
            .navigationDestination(for: Park.self, destination: { park in
                ParkDetailView(park: park)
            })
            .navigationTitle("National Parks")
        }
        .onAppear {
            Task {
                await fetchParks()
            }
        }
    }
    
    private func fetchParks() async {
        let url = URL(string: "https://developer.nps.gov/api/v1/parks?stateCode=wa&api_key=YourKey")!
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            
            let parksResponse = try JSONDecoder().decode(ParksResponse.self,  from: data)
            
            let parks = parksResponse.data
            
            self.parks = parks

        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}

struct ParkRow: View {
    
    let park: Park
    
    var body: some View {
        Rectangle()
            .aspectRatio(4/3, contentMode: .fit)
            .overlay {
                let image = park.images.first
                let urlString = image?.url
                let url = urlString.flatMap { string in
                    URL(string: string)
                }
                
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color(.systemGray4)
                }
            }
            .overlay(alignment: .bottomLeading) {
                Text(park.name)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
            }
            .clipShape(.rect(cornerRadius: 16, style: .continuous))
            .padding(.horizontal)
    }
}
