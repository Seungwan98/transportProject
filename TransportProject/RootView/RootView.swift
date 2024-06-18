import SwiftUI
import ComposableArchitecture

struct RootView: View {
    
    @State var store: StoreOf<RootFeature>

    init(store: StoreOf<RootFeature>) {
        self.store = store
    }

    var body: some View {
        
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack {
                    Text("이용하시는 서비스를").font(.system(size: 36).bold()).offset(x: 10)
                    Text("선택해주세요").font(.system(size: 36).bold()).offset(x: 10)
                    Spacer()
                    
                    
                    NavigationLink(state: RootFeature.Path.State.busScene() ) {
                        Image(systemName: "bus")
                            .resizable() // 이미지 크기 조정 가능
                            .frame(width: 50, height: 50)
                        
                    }.frame(width: 100, height: 100 ).foregroundColor(.white).background(.blue).clipShape(Circle())
                    
                   
                    
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
              
   
        } destination: { store in
            switch store.state {
            case .busScene:
                if let store = store.scope(state: \.busScene , action: \.bus ){
                   
                    BusView(store: store)
                    
                }
            case .detailScene:
                if let store = store.scope(state: \.detailScene , action: \.detail){
                    MapView(store: store)
                    
                }
            }
        }
    }
}
#Preview {
    RootView(
        store : Store(initialState: RootFeature.State()) {
            RootFeature()
        }
    )}