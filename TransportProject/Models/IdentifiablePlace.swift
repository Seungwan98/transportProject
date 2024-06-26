//
//  IndentifierPlace.swift
//  TransportProject
//
//  Created by 양승완 on 6/20/24.
//
import MapKit
import Foundation
import SwiftUI
struct IdentifiablePlace: Identifiable, Equatable {
    static func == (lhs: IdentifiablePlace, rhs: IdentifiablePlace) -> Bool {
        lhs.way == rhs.way && lhs.name == rhs.name
    }
    
    let id: UUID
    let location: CLLocationCoordinate2D
    let name: String
    var way: String = ""
    var color: Color = .gray
    
    init(id: UUID = UUID(), lat: Double, long: Double, name: String, way: String) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
        self.name = name
        self.way = way
        
    }
    
    func changeToBlue() -> IdentifiablePlace {
        var new = IdentifiablePlace.init(lat: self.location.latitude, long: self.location.longitude, name: self.name, way: self.way)
        new.color = .blue
        return new
    }

}
