//
//  DataFormatter.swift
//  TransportProject
//
//  Created by 양승완 on 7/2/24.
//

import Foundation


extension String {
    
    func getDifference() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let nowTime = Date.now
        guard let targetTime = format.date(from: self) else {return "?"}
        
        // 원하는 형식으로 다시 바꾸기
        
        let minutes = Int(targetTime.timeIntervalSince(nowTime)) / 60
        let seconds = Int(targetTime.timeIntervalSince(nowTime)) % 60
        
        var result = ""
        
        if minutes > 0 {
            result = String("\(minutes)분 \(seconds)초")
        } else {
            result = String("\(seconds)초")
        }
        
        
        return result
    }    
    func getFormatted() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
 
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "HH:mm:ss"
        guard let result = format.date(from: self) else {return ""}
        
        
        return myDateFormatter.string(from: result)
    }
    
}
