//
//  Ifconfig.swift
//  ifconfig
//
//  Created by Eliseo Martelli on 15/11/20.
//

import Foundation

struct Ifconfig: Decodable {
    var ip: String
    var country: String
    var country_iso: String
    var region_name: String
    var zip_code: String
    var city: String
    var time_zone: String
}
