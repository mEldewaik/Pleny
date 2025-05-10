//
//  APIClient.swift
//  PlenyApp
//
//  Created by Mohamed Eldewaik on 07/05/2025.
//

import Foundation
import Combine

final class APIClient {
    static let shared = APIClient()
    private init() {}

    func post<T: Codable, U: Codable>(urlString: String, body: T) -> AnyPublisher<U, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }

                if !(200..<300).contains(httpResponse.statusCode) {
                    throw NetworkError.serverError(httpResponse.statusCode)
                }

                return result.data
            }
            .decode(type: U.self, decoder: JSONDecoder())
            .mapError { $0 }
            .eraseToAnyPublisher()
    }

    func get<U: Codable>(urlString: String) -> AnyPublisher<U, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpShouldHandleCookies = true

        if let accessToken = UserSessionManager.shared.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkError.unknown
                }

                if !(200..<300).contains(httpResponse.statusCode) {
                    throw NetworkError.serverError(httpResponse.statusCode)
                }

                return result.data
            }
            .decode(type: U.self, decoder: JSONDecoder())
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}

