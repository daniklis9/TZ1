//
//  Model.swift
//  TZ1
//
//  Created by Даниил on 2024/01/15.
//

import Foundation

//class MenuResponse: Codable {
//    var status: Bool
//    var menuList: [MenuList]
//
//    enum CodingKeys: String, CodingKey {
//        case status
//        case menuList = "menuList"
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.status = try container.decode(Bool.self, forKey: .status)
//        self.menuList = try container.decode([MenuList].self, forKey: .menuList)
//    }
//}
//
//class MenuList: Codable {
//    var menuID: String
//    var image: String
//    var name: String
//    var subMenuCount: String
//
//    enum CodingKeys: String, CodingKey {
//        case menuID
//        case image
//        case name
//        case subMenuCount
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.menuID = try container.decode(String.self, forKey: .menuID)
//        self.image = try container.decode(String.self, forKey: .image)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.subMenuCount = try container.decode(String.self, forKey: .subMenuCount)
//    }
//}



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
