//
//  Result.swift
//  WidgetTest
//
//  Created by sooin on 2023/06/21.
//

import Foundation

// MARK: - Result
struct Result: Codable {
    let response: Response
    
    static var placeholder: Result {
        Result(response: Response.placeholder)
    }
}

// MARK: - Response
struct Response: Codable {
    let header: Header
    let body: Body
    
    static var placeholder: Response {
        Response(header: Header.placeholder, body: Body.placeholder)
    }
}

// MARK: - Header
struct Header: Codable {
    let resultCode, resultMsg: String
    
    static var placeholder: Header {
        Header(resultCode: "00", resultMsg: "NORMAL_SERVICE")
    }
}



// MARK: - Body
struct Body: Codable {
    let dataType: String
    let items: Items
    let pageNo, numOfRows, totalCount: Int
    
    static var placeholder: Body {
        Body(dataType: "JSON", items: Items.placeholder, pageNo: 1, numOfRows: 1000, totalCount: 8)
    }
}

// MARK: - Items
struct Items: Codable {
    let item: [Item]
    
    static var placeholder: Items {
        Items(item: [Item.placeholder])
    }
}

// MARK: - Item
struct Item: Codable {
    let baseDate, baseTime, category: String
    let nx, ny: Int
    let obsrValue: String
    
    static var placeholder: Item {
        Item(baseDate: "20230621", baseTime: "0600", category: "RN1", nx: 55, ny: 127, obsrValue: "0")
    }
}


