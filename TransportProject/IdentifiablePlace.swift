//
//  IndentifierPlace.swift
//  TransportProject
//
//  Created by 양승완 on 6/20/24.
//
import MapKit
import Foundation
struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    let name: String
    init(id: UUID = UUID(), lat: Double, long: Double, name: String) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
        self.name = name
        
    }
}
