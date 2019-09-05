//
//  NetworkResponseParserProtocol.swift
//  OtusLession15
//
//  Created by Олег Иванов on 05/09/2019.
//  Copyright © 2019 Otus. All rights reserved.
//

import Foundation

protocol NetworkResponseParserProtocol {
    func parse(data: Data?) -> ([String: Any]?)
}
