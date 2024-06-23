//
//  CLLocation+.swift
//  TransportProject
//
//  Created by 양승완 on 6/24/24.
//

import Foundation
import MapKit
extension CLLocationCoordinate2D {
  
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
        
        return from.distance(from: to)
    }
}
