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
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(park.images) { image in
                        Rectangle()
                            .aspectRatio(7/5, contentMode: .fit)
                            .containerRelativeFrame(.horizontal, count: 9, span: 8, spacing: 16)
                            .overlay {
                                AsyncImage(url: URL(string: image.url)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Color(.systemGray4)
                                }
                            }
                            .clipShape(.rect(
                                cornerRadius: 16,
                                style: .continuous)
                            )
                    }
                    .safeAreaPadding(.horizontal)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ParkDetailView(park: Park.mocked)
}
