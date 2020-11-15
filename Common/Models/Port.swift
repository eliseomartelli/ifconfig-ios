//
//  Port.swift
//  ifconfig
//
//  Created by Eliseo Martelli on 15/11/20.
//

import Foundation

struct Port: Decodable {
    var ip: String
    var port: Int
    var reachable: Bool
}
