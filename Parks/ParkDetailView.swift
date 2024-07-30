//
//  ParkDetailView.swift
//  Parks
//
//  Created by Raymond Chen on 7/29/24.
//

import SwiftUI

struct ParkDetailView: View {
    
    let park: Park
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(park.fullName)
                    .font(.largeTitle)
                Text(park.description)
            }
            .padding()
        }
    }
}

#Preview {
    ParkDetailView(park: Park.mocked)
}
