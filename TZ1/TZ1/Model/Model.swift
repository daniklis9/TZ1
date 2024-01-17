//
//  Model.swift
//  TZ1
//
//  Created by Даниил on 2024/01/15.
//

import Foundation

struct MenuResponse: Decodable {
    var status: Bool
    var menuList: [MenuList]

    enum CodingKeys: String, CodingKey {
        case status
        case menuList = "menuList"
    }
}

struct MenuList: Decodable {
    var menuID: String
    var image: String
    var name: String
    var subMenuCount: Int

    enum CodingKeys: String, CodingKey {
        case menuID
        case image
        case name
        case subMenuCount
    }
}
