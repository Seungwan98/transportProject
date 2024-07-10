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
                    
                    Text("출발지").font(.system(size: 20))
                    Button(action: {
                        print("left")
                    }, label: {
                        Text("\(viewStore.startStatnNm)").bold().font(.system(size: 40))
                    }).frame(width: 150, height: 100)
                    
                }
                
                Image(systemName: "arrow.forward")
                
                
                VStack {
                    
                    Text("목적지").font(.system(size: 20))
                    Button(action: {
                        print("left")
                    }, label: {
                        Text("\(viewStore.destinationStatnNm)").bold().font(.system(size: 40))
                    }).frame(width: 150, height: 100)
                    
                    
                }
                
                
            })
            Spacer().frame(height: 40)
                   
            HStack {
                
                Spacer()

                Text("\(viewStore.beforeNm)")

                Spacer()
                Text("\(viewStore.startNm)").onChange(of: viewStore.nowSubwayState) {
                    viewStore.send(.changed)
                }
                Spacer()


              

            }
            Spacer()

            Text(viewStore.nowSubwayState)
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

        
