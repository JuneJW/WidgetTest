//
//  Constants.swift
//  WidgetTest
//
//  Created by sooin on 2023/06/21.
//

import Foundation

struct Constants {
    
    static let API_URL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst"
    static let SERVICE_KEY = ""
    static let DATA_TYPE = "JSON"
    static let BASE_TIME = "0600"
    
    struct ParamName {
        static let serviceKey = "serviceKey"
        static let pageNo = "pageNo"
        static let numOfRows = "numOfRows"
        static let dataType = "dataType"
        static let baseDate = "base_date"
        static let baseTime = "base_time"
        static let nx = "nx"
        static let ny = "ny"
    }
}
