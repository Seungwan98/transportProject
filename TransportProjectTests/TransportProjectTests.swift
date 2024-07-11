//
//  TransportProjectTests.swift
//  TransportProjectTests
//
//  Created by 양승완 on 7/3/24.
//

import XCTest
import ComposableArchitecture
@testable import TransportProject
import AVFAudio
final class TransportProjectTests: XCTestCase, AVAudioPlayerDelegate {
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        guard let error = error else { return }
        print("occured error = \(error)")
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("did finish playing")
    }
    
    @Dependency(\.apiClient) var apiClient
    
    func testExample() async throws {
        //        print("testExample")
        //        let fileManager = JsonManager()
        //        let arr = try await fileManager.get()
        
        
        
        //  print(LocationManager().calDist(x1: 2, y1: 2, x2: 6, y2: 2, a: 1, b: 2))
        
        
        
        // 도착 예정 열차 검색
        //        let data = try await apiClient.fetchSubwayArrive("서울")
        //        print(data?.realtimeArrivalList.filter {
        //            $0.statnList.contains("1001000133")
        //
        //        })
        
        
        // sound Test
        
        //        if let path = Bundle.main.path(forResource: "alarm", ofType: "mp3") {
        //            do {
        //                let audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path ))
        //                audioPlayer.prepareToPlay()
        //                audioPlayer.play()
        //            } catch {
        //                print("err")
        //            }
        //
        //        } else {
        //            print("audio err")
        //        }
    }
    
    
    
}
