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
            
            HStack {
                
            }

                HStack {
                    Spacer()

                        Button(action: {
                            print("left")
                        }, label: {
                            Image(systemName: "plus")
                                .resizable() // 이미지 크기 조정 가능
                                .frame(width: 50, height: 50)
                        }).padding(.horizontal, 50)
                    
                        .padding(.vertical, 50)

                        .foregroundColor(.white)
                        .background(.gray)
                    Spacer()
                    Button(action: {
                        print("right")
                    }, label: {
                        Image(systemName: "plus")
                            .resizable() // 이미지 크기 조정 가능
                            .frame(width: 50, height: 50)
                    }).padding(.horizontal, 50)
                
                    .padding(.vertical, 50)

                    .foregroundColor(.white)
                    .background(.gray)
                    Spacer()

                    }
                    
                  
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

        
