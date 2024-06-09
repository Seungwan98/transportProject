import SwiftUI
import ComposableArchitecture

struct RootView: View {
    // ⭐️ 0️⃣
    @State var store: StoreOf<RootFeature>

    init(store: StoreOf<RootFeature>) {
        self.store = store
    }

    var body: some View {
        // ⭐️ 1️⃣ SwiftUI 의 NavigationStack 을 TCA 의 Reducer 를 embed 한 View 를 사용합니다.
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
              
            
            // ⭐️ 3️⃣ Path 의 State 로 이어지는 case 로 뽑아서, Destination 을 기록합니다.
            // ⭐️ 4️⃣ 이때 주의할 점은, 이게 컴파일 단계에서, 에러를 알려주는데, Path 에서 연결된 값이 하나라도 다르면 에러가 뜹니다.
            // 그래서 Path 와 이 Destination 을 연결하는 곳에서 뜨는 에러는 그냥 그러려니 하고 양쪽 다 일치하게 코드 적어주시면 됩니다ㅎ.
        } destination: { store in
            switch store.state {
            case .busScene:
                if let store = store.scope(state: \.busScene, action: \.bus){
                    BusView(store: store)
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
