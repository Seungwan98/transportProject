//
//  Collection+.swift
//  TransportProject
//
//  Created by 양승완 on 7/12/24.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
