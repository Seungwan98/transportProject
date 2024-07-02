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
                
        //원하는 형식으로 다시 바꾸기
        format.dateFormat = "HH:mm"
        let s = format.string(from: nowTime)
        let e = format.string(from: targetTime)
                
        format.dateFormat = "yyyy.MM.dd"
        let f = format.string(from: nowTime)
        let dateText = "\(f) (\(s) - \(e))"
        
        return dateText
       }
    
}
