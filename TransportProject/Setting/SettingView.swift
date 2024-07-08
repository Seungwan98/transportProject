//
//  ContentView.swift
//  runningProject
//
//  Created by 양승완 on 6/7/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
struct SettingView: View {
    @Bindable var store: StoreOf<SettingFeature>
    @State private var text = ""
    @State private var soundSelect = 0
    @State private var vibrationSelect = 0
    init(store: StoreOf<SettingFeature>) {
        self.store = store
        
    }
    
    var body: some View {
        
        
        WithViewStore(store, observe: { $0 }) { viewStore in
          
            HStack {
                Spacer().frame(width: 30)
                Text("소리").font(.title3)
                Spacer()
                Picker(selection: $soundSelect, label: Text("test")) {
                    Text("on").tag(0)
                    Text("off").tag(1)
                
                }
                .pickerStyle(.segmented).frame(width: 100)
          
                Spacer().frame(width: 30)
            }
            Spacer().frame(height: 20)
            HStack {
                Spacer().frame(width: 30)
                Text("진동").font(.title3)
                Spacer()
                Picker(selection: $vibrationSelect, label: Text("test")) {
                    Text("on").tag(0)
                    Text("off").tag(1)
                
                }
                .pickerStyle(.segmented).frame(width: 100)
          
                Spacer().frame(width: 30)
            }
            Spacer()
            
            
        }
    }
}

#Preview {
    SettingView(
        store: Store(initialState: SettingFeature.State()) {
            SettingFeature()
        }
    )}
