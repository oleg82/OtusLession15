//
//  NetworkProvider.swift
//  OtusLession15
//
//  Created by Олег Иванов on 05/09/2019.
//  Copyright © 2019 Otus. All rights reserved.
//

import Foundation

public class NetworkProvider: NetworkProviderProtocol {
    private var task: URLSessionDataTask?
    private let parser: NetworkResponseParserProtocol
    
    init(parser: NetworkResponseParserProtocol) {
        self.parser = parser
    }

    func send(with url: URL, completion: @escaping SuccessBlock) {
        task = URLSession(configuration: .default).dataTask(with: url) { [unowned self] (data, _, _) in
            defer {
                self.task = nil
            }
            
            if let response = self.parser.parse(data: data) {
                completion(response)
            }
        }
        task?.resume()
    }
}

