//
//  APIManager.swift
//  APIRxPractice
//
//  Created by 황인호 on 11/7/23.
//

import UIKit
import RxSwift
import RxCocoa


enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}

class APIManager {
      
    static func fetchBoxOfficeData(date: String) -> Observable<Movie> {
        
        return Observable<Movie>.create { observer in
            
            guard let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.movieKey)&targetDt=\(date)") else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                print("DataTask Succeed")
                if let _ = error {
                    observer.onError(APIError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    observer.onError(APIError.statusError)
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(Movie.self, from: data) {
                    observer.onNext(appData)
                }
            }.resume()
            
            return Disposables.create()
        }
    }
}


