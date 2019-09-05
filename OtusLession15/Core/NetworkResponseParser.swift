//
//  NetworkResponseParser.swift
//  OtusLession15
//
//  Created by Олег Иванов on 05/09/2019.
//  Copyright © 2019 Otus. All rights reserved.
//

import Foundation

class NetworkResponseParser: NetworkResponseParserProtocol {
    func parse(data: Data?) -> ([String: Any]?) {
        guard let data = data else { return nil }
        
        do {
            return try (JSONSerialization.jsonObject(with: data, options: []) as? [String: Any])!
        } catch {
            return nil
        }
    }
}

