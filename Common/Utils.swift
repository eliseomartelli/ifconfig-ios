//
//  Utils.swift
//  ifconfig
//
//  Created by Eliseo Martelli on 15/11/20.
//

import Foundation

struct Utils {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
