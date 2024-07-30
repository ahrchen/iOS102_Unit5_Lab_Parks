//
//  ParkResponse.swift
//  Parks
//
//  Created by Raymond Chen on 7/29/24.
//

import Foundation

struct ParksResponse: Codable {
    let data: [Park]
}

struct Park: Codable, Identifiable {
    let id: String
    let fullName: String
    let description: String
    let latitude: String
    let longitude: String
    let images: [ParkImage]
    let name: String
}

extension Park {
    static var mocked: Park {
        let jsonURL = Bundle.main.url(forResource: "park_mock", withExtension: "json")!
        let data = try! Data(contentsOf: jsonURL)
        let park = try! JSONDecoder().decode(Park.self, from: data)
        return park
    }
}

struct ParkImage: Codable {
    let title: String
    let caption: String
    let url: String
}
