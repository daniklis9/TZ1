//
//  SecondModel.swift
//  TZ1
//
//  Created by Даниил on 2024/01/16.
//

import Foundation

struct SecondMenuResponse: Decodable {
    var status: Bool
    var menuList: [SecondMenuList]?

    enum CodingKeys: String, CodingKey {
        case status
        case menuList = "menuList"
    }
}

struct SecondMenuList: Decodable {
    var id: String?
    var image: String?
    var name: String?
    var content: String?
    var price: String?
    var weight: String?
    var spicy: String?

    enum CodingKeys: String, CodingKey {
        case id
        case image
        case name
        case content
        case price
        case weight
        case spicy
    }
}
