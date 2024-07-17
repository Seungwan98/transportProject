import SwiftUI
import ComposableArchitecture
import BackgroundTasks
struct RootView: View {
    // @EnvironmentObject var locationManager: LocationManager
    @State var store: StoreOf<RootFeature>
    
    init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    var body: some View {
        
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {

            VStack {
                
                Spacer().frame(height: 40)

                Text("이용하시는 서비스를").font(.system(size: 36).bold()).offset(x: 10)
                Text("선택해주세요").font(.system(size: 36).bold()).offset(x: 10)
                Spacer()
                
                
                NavigationLink(state: RootFeature.Path.State.busScene() ) {
                    Image(systemName: "bus")
                        .resizable() // 이미지 크기 조정 가능
                        .frame(width: 50, height: 50)
                    
                }.frame(width: 100, height: 100 ).foregroundColor(.white).background(.blue).clipShape(Circle())
                
                Spacer().frame(height: 20)
                
                NavigationLink(state: RootFeature.Path.State.subwayScene() ) {
                    Image(systemName: "tram")
                        .resizable() // 이미지 크기 조정 가능
                        .frame(width: 50, height: 50)
                    
                }.frame(width: 100, height: 100 ).foregroundColor(.white).background(.blue).clipShape(Circle())
                
        
                
                
                Spacer().frame(height: 250)
            }
            
            
        } destination: { store in
            switch store.state {
            case .busScene:
                if let store = store.scope(state: \.busScene, action: \.bus ) {
                    
                    BusListView(store: store)
                    
                }
            case .detailScene:
                if let store = store.scope(state: \.detailScene, action: \.detail) {
                    BusMapView(store: store)
                    
                }
            case .subwayScene:
                if let store = store.scope(state: \.subwayScene, action: \.subway) {
                    SubwayListView(store: store)
                }
            case .subwayResultScene:
                if let store = store.scope(state: \.subwayResultScene, action: \.subwayResult) {
                    SubwayResultView(store: store)
                }
            
            }
        }
    }
    
    
    
    
    
    
}


#Preview {
    RootView(
        store: Store(initialState: RootFeature.State()) {
            RootFeature()
        }
    )}
