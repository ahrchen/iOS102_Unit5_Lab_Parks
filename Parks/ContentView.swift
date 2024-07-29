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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
                await fetchParks()
            }
        }
    }
    
    private func fetchParks() async {
        let url = URL(string: "https://developer.nps.gov/api/v1/parks?stateCode=wa&api_key={Your own key}")!
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            
            let parksResponse = try JSONDecoder().decode(ParksResponse.self,  from: data)
            
            let parks = parksResponse.data
            
            self.parks = parks
            
            for park in parks {
                print(park.fullName)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}
