//
//  SubwayModel.swift
//  TransportProject
//
//  Created by 양승완 on 7/2/24.
//

import Foundation

struct SubwayModel: Identifiable {
    var id = UUID()
    
    
    let beginRow, endRow, curPage, pageRow: JSONNull?
    let totalCount, rowNum, selectedCount: Int
    let subwayID: String
    let subwayNm: SubwayNm
    let statnID, statnNm, trainNo, lastRecptnDt: String
    let recptnDt, updnLine, statnTid, statnTnm: String
    let trainSttus, directAt, lstcarAt: String
    
    
    func getState() -> String {
        var result = ""
        switch trainSttus {
        case "0":
            result = "진입"
        case "1":
            result = "도착"
        case "2":
            result = "출발"
        case "3":
            result = "전역출발"
        default:
            break
        }
        return result
    }
    
    func getWay() -> String {
        var result = ""
        switch updnLine {
        case "0":
            result = "(서울방면)"
        case "1":
            result = "(\(statnTnm)방면)"
      
        default:
            break
        }
        return result
    }
    
}
