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
            VStack(alignment: .center, spacing: 20, content: {

                HStack {

                    Text("출발지").font(.system(size: 20))
                    Spacer().frame(width: 130)
                    Text("목적지").font(.system(size: 20))
                    
                    
                }
                
                HStack {
                    
                    
                    
                    Button(action: {
                        print("left")
                    }, label: {
                        Text("\(viewStore.startStatnNm )").bold().font(.system(size: 40))
                    }).frame(width: 150, height: 100)
                    
                    
                    Image(systemName: "arrow.forward")
                    
                    
                    Button(action: {
                        print("left")
                    }, label: {
                        Text("\(viewStore.destinationStatnNm)").bold().font(.system(size: 40))
                    }).frame(width: 150, height: 100)
                }
                
                
                Spacer().frame(height: 0)
                
                VStack(alignment: .center, spacing: 40, content: {
                    

                    
                    Text("현재위치").bold().font(.system(size: 30))
                    
                    HStack {
                        
                        Spacer()
                        Text("\(viewStore.startNm)").onChange(of: viewStore.nowSubwayState) {
                           //  viewStore.send(.changed)
                        }.bold().font(.system(size: 20))
                        
                        
                        Image(systemName: "arrow.forward")

                        Text("\(viewStore.nextNm)").bold().font(.system(size: 20))
                        
                        
                        Spacer()
                        
                        
                    }
                    Spacer().frame(height: 20)

                    Text("상세위치").bold().font(.system(size: 30))
                    Text(viewStore.nowSubwayState).bold().font(.system(size: 20))
                    
                    Spacer().frame(height: 0)


                })
                
                
                })
                
                
            Spacer()

            Button(action: {
                print("touch")
                viewStore.send(.stopAlarm)
            }, label: {
                Text("알람 종료").bold().font(.system(size: 20))
            }).frame(width: 360, height: 60).background(Color(uiColor: UIColor.systemBlue) ).clipShape(.capsule).foregroundColor(.white)  .saturation(viewStore.btnEnabled ? 1 : 0)


           
        }.onAppear {  store.send(.onAppear)  }.alert($store.scope(state: \.alert, action: \.alert))
        
       

    }
}



#Preview {
    
    
    
    
    SubwayResultView(
        store: Store(initialState: SubwayResultFeature.State()) {
            SubwayResultFeature()
        }
    )}

        
