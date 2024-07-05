//
//  SubwayView.swift
//  runningProject
//
//  Created by 양승완 on 6/7/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
struct SubwayPickView: View {
    @Bindable var store: StoreOf<SubwayPickFeature>
    @State private var text = ""
    
    init(store: StoreOf<SubwayPickFeature>) {
        self.store = store
        
    }
    
    var body: some View {
        
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            Spacer().frame(height: 80)
            
            HStack(alignment: .center, spacing: 30, content: {
                
                
                VStack {
                    
                    Text("출발").font(.system(size: 20))
                    Button(action: {
                        print("left")
                    }, label: {
                        Text("천호").bold().font(.system(size: 40))
                    })
                    
                }
                
                Image(systemName: "arrow.forward")
                
                
                VStack {
                    
                    Text("목적").font(.system(size: 20))
                    Button(action: {
                        print("left")
                    }, label: {
                        Text("강동").bold().font(.system(size: 40))
                    })
                    
                    
                }
                
                
            }
            
            )
                
            
            
            Spacer()
            
            
            
        }
        
        
        
    }
}



#Preview {
    SubwayPickView(
        store: Store(initialState: SubwayPickFeature.State()) {
            SubwayPickFeature()
        }
    )}


