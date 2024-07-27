//
//  ContentView.swift
//  Parks
//
//  Created by Raymond Chen on 7/25/24.
//

import SwiftUI

struct ContentView: View {
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
                guard let url = URL(string: "https://developer.nps.gov/api/v1/parks?stateCode=wa&api_key={YOUR_API_KEY}") else {
                    return
                }
                do {
                    let(data, _) = try await URLSession.shared.data(from: url)
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    let prettyPrintedData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    if let prettyPrintedString = String(data:prettyPrintedData, encoding: .utf8) {
                        print(prettyPrintedString)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
