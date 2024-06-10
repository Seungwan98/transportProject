//
//  ContentView.swift
//  runningProject
//
//  Created by 양승완 on 5/31/24.
//

import SwiftUI
import ComposableArchitecture


struct StartView : View {
    var store: StoreOf<StartFeature>
    
    init(store: StoreOf<StartFeature>){
        self.store = store
    }
    var body: some View {
        
        
        NavigationStack() {
            VStack {
                Text("이용하시는 서비스를").font(.system(size: 36).bold()).offset(x: 10)
                Text("선택해주세요").font(.system(size: 36).bold()).offset(x: 10)
                Spacer()
                
             
                Button(action: {
                    
                }) {
                    Image(systemName: "car")
                        .resizable() // 이미지 크기 조정 가능
                        .frame(width: 50, height: 50)
                    
                }.frame(width: 100, height: 100 ).foregroundColor(.white).background(.blue).clipShape(Circle())
                
                Button(action: {
                    
                }) {
                    Image(systemName: "tram")
                        .resizable() // 이미지 크기 조정 가능
                        .frame(width: 50, height: 50)
                    
                }.frame(width: 100, height: 100 ).foregroundColor(.white).background(.blue).clipShape(Circle())
                Spacer()
            }
            
            
            
            
            
        }
    } 
    
    
}
