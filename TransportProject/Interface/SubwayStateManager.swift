//
//  SubwayState.swift
//  TransportProject
//
//  Created by 양승완 on 7/11/24.
//

import Foundation
import ComposableArchitecture

@DependencyClient
struct SubwayStateManager {
    
    var getWay: (String, String, Int) throws -> [String]
}
extension DependencyValues {
    var subwayStateManager: SubwayStateManager {
        get { self[SubwayStateManager.self] }
        set { self[SubwayStateManager.self] = newValue }
    }
}

extension SubwayStateManager: DependencyKey {
    
    static var liveValue = Self(
        
        getWay: { start, destination, lineNum  in
            @Dependency(\.apiClient) var apiClient

            // 서울 지하철 1호선
            let line1_sinchang = ["연천", "진곡", "청산", "소요산", "동두천", "보산", "동두천중앙", "지행", "덕정", "덕계", "양주", "녹양", "가능", "의정부", "회룡", "망월사", "도봉산", "도봉", "방학", "창동", "녹천", "월계", "광운대", "석계", "신이문", "외대앞", "회기", "청량리", "제기동", "신설동", "동묘앞", "동대문", "종로5가", "종로3가", "종각", "시청", "서울", "남영", "용산", "노량진", "대방", "신길", "영등포", "신도림", "구로", "가산디지털단지", "독산", "금천구청", "석수", "관악", "안양", "명학", "금정", "군포", "당정", "의왕", "성균관대", "화서", "수원", "세류", "병점", "세마", "오산대", "오산", "진위", "송탄", "서정리", "지제", "평택", "성환", "직산", "두정", "천안", "봉명", "쌍용", "아산", "탕정", "배방", "온양온천", "신창"]
            
            let line1_incheon = ["연천", "진곡", "청산", "소요산", "동두천", "보산", "동두천중앙", "지행", "덕정", "덕계", "양주", "녹양", "가능", "의정부", "회룡", "망월사", "도봉산", "도봉", "방학", "창동", "녹천", "월계", "광운대", "석계", "신이문", "외대앞", "회기", "청량리", "제기동", "신설동", "동묘앞", "동대문", "종로5가", "종로3가", "종각", "시청", "서울", "남영", "용산", "노량진", "대방", "신길", "영등포", "신도림", "구로", "구일", "개봉", "오류동", "온수", "역곡", "소사", "부천", "중동", "송내", "부개", "부평", "백운", "동암", "간석", "주안", "도화", "제물포", "도원", "동인천", "인천"]
            
            // 서울 지하철 2호선 (순환선)
            let line2_inner = ["시청", "을지로입구", "을지로3가", "을지로4가", "동대문역사문화공원", "신당", "상왕십리", "왕십리", "한양대", "뚝섬", "성수", "건대입구", "구의", "강변", "잠실나루", "잠실", "신천", "종합운동장", "삼성", "선릉", "역삼", "강남", "교대", "서초", "방배", "사당", "낙성대", "서울대입구", "봉천", "신림", "신대방", "구로디지털단지", "대림", "신도림", "문래", "영등포구청", "당산", "합정", "홍대입구", "신촌", "이대", "아현", "충정로"]
            
            // 서울 지하철 2호선 (성수지선)
            let line2_sinseol = ["성수", "용답", "신답", "용두", "신설동"]
            
            // 서울 지하철 2호선 (신도림지선)
            let line2_guro = ["신도림", "도림천", "양천구청", "신정네거리", "까치산"]
            
            // 서울 지하철 3호선
            let line3 = ["대화", "주엽", "정발산", "마두", "백석", "대곡", "화정", "원당", "원흥", "삼송", "지축", "구파발", "연신내", "불광", "녹번", "홍제", "무악재", "독립문", "경복궁", "안국", "종로3가", "을지로3가", "충무로", "동대입구", "약수", "금호", "옥수", "압구정", "신사", "잠원", "고속터미널", "교대", "남부터미널", "양재", "매봉", "도곡", "대치", "학여울", "대청", "일원", "수서", "가락시장", "경찰병원", "오금"]
            
            // 서울 지하철 4호선
            let line4 = ["당고개", "상계", "노원", "창동", "쌍문", "수유", "미아", "미아사거리", "길음", "성신여대입구", "한성대입구", "혜화", "동대문", "동대문역사문화공원", "충무로", "명동", "회현", "서울역", "숙대입구", "삼각지", "신용산", "이촌", "동작", "총신대입구", "사당", "남태령", "선바위", "경마공원", "대공원", "과천", "정부과천청사", "인덕원", "평촌", "범계", "금정", "산본", "수리산", "대야미", "반월", "상록수", "한대앞", "중앙", "고잔", "초지", "안산", "신길온천", "정왕", "오이도"]
            
            // 서울 지하철 5호선 (방화행)
            let line5_banghwa = ["방화", "개화산", "김포공항", "송정", "마곡", "발산", "우장산", "화곡", "까치산", "신정", "목동", "오목교", "양평", "영등포구청", "영등포시장", "신길", "여의도", "여의나루", "마포", "공덕", "애오개", "충정로", "서대문", "광화문", "종로3가", "을지로4가", "동대문역사문화공원", "청구", "신금호", "행당", "왕십리", "마장", "답십리", "장한평", "군자", "아차산", "광나루", "천호", "강동"]
            
            // 서울 지하철 5호선 (마천행)
            let line5_macheon = ["상일동", "강동", "천호", "강동구청", "길동", "굽은다리", "명일", "고덕", "상일동", "강일", "미사", "하남풍산", "하남시청", "하남검단산", "마천"]
            
            // 서울 지하철 6호선
            let line6 = ["응암", "역촌", "불광", "독바위", "연신내", "구산", "새절", "증산", "디지털미디어시티", "월드컵경기장", "마포구청", "망원", "합정", "상수", "광흥창", "대흥", "공덕", "효창공원앞", "삼각지", "녹사평", "이태원", "한강진", "버티고개", "약수", "청구", "신당", "동묘앞", "창신", "보문", "안암", "고려대", "월곡", "상월곡", "돌곶이", "석계", "태릉입구", "화랑대", "봉화산", "신내"]
            
            // 서울 지하철 7호선
            let line7 = ["장암", "도봉산", "수락산", "마들", "노원", "중계", "하계", "공릉", "태릉입구", "먹골", "중화", "상봉", "면목", "사가정", "용마산", "중곡", "군자", "어린이대공원", "건대입구", "뚝섬유원지", "청담", "강남구청", "학동", "논현", "반포", "고속터미널", "내방", "이수", "남성", "숭실대입구", "상도", "장승배기", "신대방삼거리", "보라매", "신풍", "대림", "남구로", "가산디지털단지", "철산", "광명사거리", "천왕", "온수", "까치울", "부천종합운동장", "춘의", "신중동", "부천시청", "상동", "삼산체육관", "굴포천", "부평구청"]
            
            // 서울 지하철 8호선
            let line8 = ["암사", "천호", "강동구청", "몽촌토성", "잠실", "석촌", "송파", "가락시장", "문정", "장지", "복정", "산성", "남한산성입구", "단대오거리", "신흥", "수진", "모란"]
            
            // 서울 지하철 9호선 (개화행)
            let line9_gaehwa = ["개화", "김포공항", "공항시장", "신방화", "마곡나루", "양천향교", "가양", "증미", "등촌", "염창", "신목동", "선유도", "당산", "국회의사당", "여의도", "샛강", "노량진", "노들", "흑석", "동작", "구반포", "신반포", "고속터미널", "사평", "신논현", "언주", "선정릉", "삼성중앙", "봉은사", "종합운동장", "삼전", "석촌고분", "석촌", "송파나루", "한성백제", "올림픽공원", "둔촌오륜", "중앙보훈병원"]
            
            // 경의중앙선
            let gyeonguiJungang = ["문산", "파주", "월롱", "금촌", "금릉", "운정", "야당", "탄현", "일산", "풍산", "백마", "곡산", "대곡", "능곡", "행신", "강매", "화전", "수색", "디지털미디어시티", "가좌", "신촌(경의중앙선)", "서울", "서강대", "홍대입구", "공덕", "효창공원앞", "용산", "이촌", "서빙고", "한남", "옥수", "응봉", "왕십리", "청량리", "회기", "중랑", "상봉", "망우", "양원", "구리", "도농", "양정", "덕소", "도심", "팔당", "운길산", "양수", "신원", "국수", "아신", "오빈", "양평", "원덕", "용문", "지평"]
            
            // 경춘선
            let gyeongchun = ["청량리", "회기", "중랑", "상봉", "망우", "신내", "갈매", "별내", "퇴계원", "사릉", "금곡", "평내호평", "천마산", "마석", "대성리", "청평", "상천", "가평", "굴봉산", "백양리", "강촌", "김유정", "남춘천", "춘천"]
            
            // 공항철도
            let airportRailroad = ["서울", "공덕", "홍대입구", "디지털미디어시티", "마곡나루", "김포공항", "공항시장", "계양", "검암", "운서", "공항화물청사", "인천공항1터미널", "인천공항2터미널"]
            
            // 신분당선
            let shinbundang = ["강남", "양재", "양재시민의숲", "청계산입구", "판교", "정자", "미금", "동천", "수지구청", "성복", "상현", "광교중앙", "광교"]
            
            // 우이신설선
            let uisinseol = ["북한산우이", "솔밭공원", "4.19민주묘지", "가오리", "화계", "삼양", "삼양사거리", "솔샘", "북한산보국문", "정릉", "성신여대입구", "보문", "신설동"]
            
            // 경강선
            let gyeonggang = ["판교", "이매", "삼동", "경기광주", "초월", "곤지암", "신둔도예촌", "이천", "부발", "세종대왕릉", "여주"]
            
            // 서해선
            let seohae = ["소사", "소새울", "시흥대야", "신천", "신현", "시흥능곡", "시흥시청", "시흥대야", "신천", "신현", "시흥능곡", "달미", "선부", "초지", "원시"]
            
            // 수인분당선
            let suinbundang = ["왕십리", "서울숲", "압구정로데오", "강남구청", "선정릉", "선릉", "한티", "도곡", "구룡", "개포동", "대모산입구", "수서", "복정", "가천대", "태평", "모란", "야탑", "이매", "서현", "수내", "정자", "미금", "오리", "죽전", "보정", "구성", "신갈", "기흥", "상갈", "청명", "영통", "망포", "매탄권선", "수원시청", "매교", "수원", "고색", "오목천", "어천", "야목", "사리", "한대앞", "중앙", "고잔", "초지", "안산", "신길온천", "정왕", "오이도", "달월", "월곶", "소래포구", "인천논현", "호구포", "남동인더스파크", "원인재", "연수", "송도", "인하대", "숭의", "신포", "인천"]
            
            // 모든 노선 배열
            lazy var allLines: [[String]] = [line1_sinchang, line1_incheon, line2_inner, line2_sinseol, line2_guro, line3, line4, line5_banghwa, line5_macheon, line6, line7, line8, line9_gaehwa, gyeonguiJungang, gyeongchun, airportRailroad, shinbundang, uisinseol, gyeonggang, seohae, suinbundang]
            
           
            
            
            var lines: [[String]] = []
            
            switch lineNum {
            case 0:
                lines = Array(allLines[0...1])
            case 1:
                lines = Array(allLines[2...4])
            case 2:
                lines = [allLines[5]]
            case 3:
                lines = [allLines[6]]
            case 4:
                lines = Array(allLines[7...8])
            case 5:
                lines = [allLines[9]]
            case 6:
                lines = [allLines[10]]
            case 7:
                lines = [allLines[11]]
            case 8:
                lines = [allLines[12]]
            case 9:
                lines = [allLines[13]]
            case 10:
                lines = [allLines[14]]
            case 11:
                lines = [allLines[15]]
            case 12:
                lines = [allLines[16]]
            case 13:
                lines = [allLines[17]]
            case 14:
                lines = [allLines[18]]
            case 15:
                lines = [allLines[19]]
            case 16:
                lines = [allLines[20]]
                
                
            default:
                break
            }
            
            var result: [String] = []
            var end = false
            lines.forEach { line in
                
                
                
                print("\(line.contains(start)) ,  \(line.contains(destination))")
                if line.contains(start) && line.contains(destination) {
                    result = getDirection(start: start, destination: destination, line: line)
                    return
                    
                    
                    
                }
                
            }
            
            if result.isEmpty {
                result = lines.first!
            }
            
            
            return result
            
            
            
            
            func getDirection(start: String, destination: String, line: [String]) -> [String] {
                var line: [String] = line
                let firstIdx = Int(line.firstIndex(of: start)!)
                let lastIdx = Int(line.firstIndex(of: destination)!)
                
                
                if Int(line.firstIndex(of: start)!) > Int(line.firstIndex(of: destination)!) {
                    
                    return Array(line[lastIdx...firstIdx]).reversed()
                    
                } else {
                    return Array(line[firstIdx...lastIdx])
                }
                
                
                
            }
            
            
            
            
            
        }
        
    )
    
    
    
}
