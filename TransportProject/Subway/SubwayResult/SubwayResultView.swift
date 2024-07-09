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
            
            Spacer().frame(height: 40)

            
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
                
                
            } )
            Spacer().frame(height: 40)
                   
            HStack {
                Spacer()
                Text(viewStore.nowSubwayNm).onChange(of: viewStore.nowSubwayNm) {
                    viewStore.send(.changed)
                }

                Spacer()
                Text(viewStore.nowSubwayState)
                Spacer()

            }
            Spacer()
           
        }.onAppear {  store.send(.onAppear)  }
        
       

    }
}



#Preview {
    
    
    
    
    SubwayResultView(
        store: Store(initialState: SubwayResultFeature.State()) {
            SubwayResultFeature()
        }
    )}

        
