//
//  WeatherView.swift
//  WidgetTest
//
//  Created by sooin on 2023/06/21.
//

import SwiftUI

struct WeatherView: View {
    
    @State private var defaultString = "날씨 보기"
    @State private var fetching = false
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center) {
                Image(systemName: "person")
                
                VStack {
                    Button {
                        Task {
                            await getWeather()
                        }
                    } label: {
                        Text("Click")
                    }

                }
            }
            
            if fetching {
                ProgressView()
            } else {
                VStack {
                    Text(defaultString)
                        .font(.largeTitle)
                    
                    HStack {
                        Text(defaultString)
                    }
                }
            }
        }
    }

    func getWeather() async {
        let url = Constants.API_URL
        
        let params: [String: Any] = [Constants.ParamName.serviceKey : Constants.SERVICE_KEY,
                                     Constants.ParamName.pageNo : 1,
                                     Constants.ParamName.numOfRows : "100",
                                     Constants.ParamName.dataType : Constants.DATA_TYPE,
                                     Constants.ParamName.baseDate : Utils.shared.getCurrentDate(),
                                     Constants.ParamName.baseTime : Constants.BASE_TIME,
                                     Constants.ParamName.nx : 55,
                                     Constants.ParamName.ny : 127
        ]
        
        let apiService = APIService(urlString: url, queryParams: params)
        fetching.toggle()
        
        defer {
            fetching.toggle()
        }
        do {
            let result: Result = try await apiService.getJSON()
            defaultString = result.response.body.items.item[0].baseDate
        } catch {
            defaultString = error.localizedDescription
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
