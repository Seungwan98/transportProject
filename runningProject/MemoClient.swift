//
//  MemoClient.swift
//  runningProject
//
//  Created by 양승완 on 6/7/24.
//

import Foundation
import ComposableArchitecture

struct MemoClient {
    var fetchMemoItem: (_ id: String) -> Effect
