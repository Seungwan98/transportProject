//
//  LocationManager.swift
//  TransportProject
//
//  Created by 양승완 on 6/25/24.
//

import Foundation
import CoreLocation
import UserNotifications
import BackgroundTasks
import ComposableArchitecture
import Combine
import SwiftUI
import AVFAudio

// protocol LocationManaging {
//    var resultPositions: [CLLocationCoordinate2D] { get set }
//    func startLocation(positions: [CLLocationCoordinate2D])
//
// }
//
//
// extension DependencyValues {
//    var locationManaging: LocationManaging {
//        get { self[LocationManageKey.self] }
//        set { self[LocationManageKey.self] = newValue }
//    }
//    private enum LocationManageKey: DependencyKey {
//        static var liveValue: LocationManaging = LocationManager() as! LocationManaging
//    }
// }
class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    
    
    
    var store: BusMapFeature.Action?
    private var anyCancelled = Set<AnyCancellable>()
    private var locationManager: CLLocationManager
    @Published var currentLocation: CLLocation?
    @Published var alarm: Bool = true
    @Published var resultPositions = [BusPicker]()
    @Published var timer = false
    
    
    private var destination: CLLocationCoordinate2D?
    private var positions: [BusPicker]?
    override init() {
        
        locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        
        
        
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Locationdistance")
        guard let location = locations.last, let destination = self.destination, locations.last?.coordinate != nil, let positions = self.positions else { return }
        self.currentLocation = location
        var lowest = Double.infinity
        var finalIndex = 0
        for i in 1..<positions.count {
            let firstvalue = positions[i-1].location
            let secondvalue = positions[i].location
            let distance = self.shortestDistanceFromPointToLineSegment(point: Point( x: location.coordinate.longitude, y: location.coordinate.latitude), linePoint1: Point( x: secondvalue.longitude, y: secondvalue.latitude), linePoint2: Point( x: firstvalue.longitude, y: firstvalue.latitude))
            
            if lowest > distance {
                lowest = distance
                finalIndex = i
                
                
            }
        }
        
        var resultPositions = [BusPicker]()
        resultPositions.append(positions[finalIndex - 1])
        resultPositions.append(positions[finalIndex])
        self.resultPositions = resultPositions
        
        
        
        
        if destination.distance(from: location.coordinate) < 50 && alarm {
            self.locationManager.stopUpdatingLocation()

            self.timer = true
            self.alarm = false
            
            _ = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] timer in
                guard let self = self else {return}
                if !self.timer {
                    timer.invalidate()
                    print("invalidate")
                    
                    
                }
                
              
             
                
                

                guard let currentLocation = self.currentLocation else {return}
                BackgroundManager.shared.scheduleNotification(currentLocation: currentLocation)
                
            }
            
            
            
            
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    func startLocation(positions: [BusPicker]) {
        self.destination = positions.last?.location
        self.positions = positions
        
        
        locationManager.startUpdatingLocation()
    }
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    
    
    func shortestDistanceFromPointToLineSegment(point: Point, linePoint1: Point, linePoint2: Point) -> Double {
        let (x1, y1) = (linePoint1.x, linePoint1.y)
        let (x2, y2) = (linePoint2.x, linePoint2.y)
        let (px, py) = (point.x, point.y)
        
        // 선분의 두 끝점이 동일한 경우 (즉, 선분의 길이가 0인 경우)
        if x1 == x2 && y1 == y2 {
            return distanceBetweenPoints(p1: point, p2: linePoint1)
        }
        
        // 선분의 제곱 길이 계산
        let lineLengthSquared = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)
        
        // 점과 선분의 첫 번째 끝점 간의 벡터
        let t = ((px - x1) * (x2 - x1) + (py - y1) * (y2 - y1)) / lineLengthSquared
        
        if t < 0.0 {
            return distanceBetweenPoints(p1: point, p2: linePoint1)
        } else if t > 1.0 {
            return distanceBetweenPoints(p1: point, p2: linePoint2)
        }
        
        // 선분 위의 점 계산
        let projection = Point(x: x1 + t * (x2 - x1), y: y1 + t * (y2 - y1))
        
        return distanceBetweenPoints(p1: point, p2: projection)
    }
    
    // 두 점 사이의 거리 계산 함수
    func distanceBetweenPoints(p1: Point, p2: Point) -> Double {
        return sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y))
    }
    
    struct Point {
        var x: Double
        var y: Double
    }
    
    
}
