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
    
    static func downloaded(from baseUrl: URL, completion: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: baseUrl) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { completion(UIImage(named: "AppIcon") ?? UIImage())
                    return }
            DispatchQueue.main.async {
               completion(image)
            }
        }.resume()
    }
    
    static func downloaded(from link: String, completion: @escaping (UIImage) -> Void) {
        guard let baseUrl = URL(string: link) else { completion(UIImage(named: "AppIcon") ?? UIImage())
            return }
        ApiManager.downloaded(from: baseUrl) { image in
            completion(image)
        }
    }
    
    private func handleUrl(endpoint: EndpointsProtocol) -> URLRequest? {
        guard let baseUrl = URL(string: endpoint.baseURL + endpoint.path) else { return nil }
        return URLRequest(url: baseUrl)
    }
}
