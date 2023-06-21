//
//  APIService.swift
//  WidgetTest
//
//  Created by sooin on 2023/06/21.
//

import Foundation

class APIService {
    
    let urlString: String
//    let headers: [String: String]
    let queryParams: [String: Any]
    
    init(urlString: String, queryParams: [String: Any]) {
        self.urlString = urlString
//        self.headers = headers
        self.queryParams = queryParams
    }
    
    func getJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                               keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) async throws -> T {
        guard
            var urlComponents = URLComponents(string: urlString)
        else {
            throw APIError.invalidURL
        }
        
        // 쿼리 파라미터 추가
        urlComponents.queryItems = queryParams.map { key, value in
            let stringValue: String
            
            if let intValue = value as? Int {
                stringValue = String(intValue)
            } else if let strValue = value as? String {
                stringValue = strValue
            } else {
                fatalError("유효하지 않은 데이터 타입")
            }
            
            return URLQueryItem(name: key, value: stringValue)
        }
        
        guard let url = urlComponents.url else {
            throw APIError.queryParam
        }
        
        
        do {
            var request = URLRequest(url: url)
//            request.allHTTPHeaderFields = headers
            
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy

            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
            
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
}


enum APIError: Error, LocalizedError {
    case invalidURL
    case queryParam
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("[Error] - endpoint url", comment: "")
        case .queryParam:
            return NSLocalizedString("[Error] - query error", comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("[Error] - Response failed", comment: "")
        case .dataTaskError(let string):
            return string
        case .corruptData:
            return NSLocalizedString("[Error] - Data corrupt", comment: "")
        case .decodingError(let string):
            return string
        }
    }
}

