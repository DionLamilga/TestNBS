//
//  ApiCall.swift
//  TestNBS
//
//  Created by Dion Lamilga on 13/07/24.
//

import UIKit
import RxSwift


class APIService {
    static func fetchData<T: Decodable>(from urlString: String, model: T.Type, queryItems: [URLQueryItem]? = nil) -> Observable<T> {
        return Observable.create { observer in
            guard var components = URLComponents(string: urlString) else {
                return Disposables.create()
            }

            if let queryItems = queryItems {
                components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
            }

            guard let url = components.url else {
                return Disposables.create()
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMzE5Y2I3MmM2OGQ1MjU5NjEyZWUyNzY0ZmFkMjdmNSIsIm5iZiI6MTcyMDYyNzU2My4xOTU1Niwic3ViIjoiNjY4ZWIwM2Q2ZGEwNjgxZmE1ZWJmNGQ4Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.G1z-7huUobhZyeYLeCkC4hlo_VGO02Jv58xN9wRW8lo"
            ]

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let data = data else {
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(model, from: data)
                    observer.onNext(decodedData)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
