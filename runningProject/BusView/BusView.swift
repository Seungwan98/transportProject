//
//  ContentView.swift
//  runningProject
//
//  Created by 양승완 on 6/7/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
struct BusView : View {
    var store: StoreOf<BusFeature>
    @State private var text = ""
    
    var body: some View {
        WithViewStore(store, observe: { $0 }){viewStore in
            HStack {
                
                Button(action: {
                    viewStore.send(.onAppear)
                }) {
                    Image(systemName: "car")
                        .resizable() // 이미지 크기 조정 가능
                        .frame(width: 50, height: 50)
                    
                }.frame(width: 100, height: 100 ).foregroundColor(.white).background(.blue).clipShape(Circle())
                HStack {
                   
                    Text("하이\(viewStore.state.result)")
                    Image(systemName: "magnifyingglass")
                    
                    TextField("Search", text: $text)
                        .foregroundColor(.primary)
                    
                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                        }
                    } else {
                        EmptyView()
                    }
                }
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
            }
            .padding(.horizontal)
            Spacer()
            
        }
    }
}


#Preview {
    BusView(
        store : Store(initialState: BusFeature.State()) {
            BusFeature()
        }
    )}
