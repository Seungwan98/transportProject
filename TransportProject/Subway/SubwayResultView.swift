//
//  SubwayView.swift
//  runningProject
//
//  Created by 양승완 on 6/7/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
struct SubwayResultView: View {
    @Bindable var store: StoreOf<SubwayResultFeature>
    @State private var text = ""
    
    init(store: StoreOf<SubwayResultFeature>) {
        self.store = store
        
    }
    
    var body: some View {
        
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack {
                Spacer()
                Text(viewStore.startPosition).font(.largeTitle)

                Spacer()
                Text(viewStore.destination).font(.largeTitle)
                Spacer()

            }
           
        }
        
       

    }
}



#Preview {
    SubwayResultView(
        store: Store(initialState: SubwayResultFeature.State()) {
            SubwayResultFeature()
        }
    )}

        
