//
//  File.swift
//  ifconfig
//
//  Created by Eliseo Martelli on 15/11/20.
//

import Foundation

enum IfconfigAPIError: Error {
    case invalidURL
    case invalidSerialization
    case badHTTPResponse
    case error(NSError)
    case noData
}

protocol IfconfigRepositoryService {
    func getIfconfig(completion: @escaping (Result<Ifconfig, IfconfigAPIError>) -> ())
    func getPort(port: Int, completion: @escaping (Result<Port, IfconfigAPIError>) -> ())
}

class IfconfigAPIService: IfconfigRepositoryService {
    static let shared = IfconfigAPIService()
    private let baseURL = "https://ifconfig.co"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    private init() {}
    
    func getIfconfig(completion: @escaping (Result<Ifconfig, IfconfigAPIError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/json") else {
            completion(.failure(.invalidURL))
            return
        }
        executeDataTaskAndEncode(with: url, completion: completion)
    }
    
    func getPort(port: Int, completion: @escaping (Result<Port, IfconfigAPIError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/port/\(port)") else {
            completion(.failure(.invalidURL))
            return
        }
        executeDataTaskAndEncode(with: url, completion: completion)
    }
    
    private func executeDataTaskAndEncode<D: Decodable>(with url: URL, completion: @escaping (Result<D, IfconfigAPIError>) -> ()) {
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                self.executeInMainThread(result: .failure(.error(error as NSError)), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                self.executeInMainThread(result: .failure(.badHTTPResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeInMainThread(result: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let model = try self.jsonDecoder.decode(D.self, from: data)
                self.executeInMainThread(result: .success(model), completion: completion)
            } catch let error as NSError{
                print(error.localizedDescription)
                self.executeInMainThread(result: .failure(.invalidSerialization), completion: completion)
            }
        }.resume()
    }
    
    private func executeInMainThread<D: Decodable>(result: Result<D, IfconfigAPIError>, completion: @escaping (Result<D, IfconfigAPIError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
