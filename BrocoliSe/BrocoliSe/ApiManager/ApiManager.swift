//
//  ApiManager.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 14/11/21.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case badURL
    case badRequest
    case noConnectivy
    case failed
    case noData
    case unableToDecode
}

protocol ApiManagerProtocol {
    func fetch<T: Codable>(request: EndpointsProtocol, model: T.Type, completion: @escaping (Result<[T], NetworkError>) -> Void)
}

class ApiManager: ApiManagerProtocol {
    private var task: URLSessionTask?
    
    func fetch<T: Codable>(request: EndpointsProtocol, model: T.Type, completion: @escaping (Result<[T], NetworkError>) -> Void) {
        guard let urlResquest = handleUrl(endpoint: request) else {
            completion(.failure(.badURL))
            return
        }
        
        task = URLSession.shared.dataTask(with: urlResquest) { data, response, error in
            if error != nil {
                completion(.failure(.noConnectivy))
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    guard let responseData = data else {
                        completion(.failure(.noData))
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([T].self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(.unableToDecode))
                    }
                case 501...599: completion(.failure(.badRequest))
                default: completion(.failure(.failed))
                }
            }
        }
        task?.resume()
    }
    
    private func handleUrl(endpoint: EndpointsProtocol) -> URLRequest? {
        guard let baseUrl = URL(string: endpoint.baseURL + endpoint.path) else { return nil }
        return URLRequest(url: baseUrl)
    }
}
