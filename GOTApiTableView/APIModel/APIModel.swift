//
//  APIModel.swift
//  GOTApiTableView
//
//  Created by Randy Morales on 9/7/23.
//

import Foundation

struct APIModel : Codable {
    
    let id : Int?
    let firstName : String?
    let lastName : String?
    let fullName : String?
    let title : String?
    let family : String?
    let image : String?
    let imageUrl : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case firstName = "firstName"
        case lastName = "lastName"
        case fullName = "fullName"
        case title = "title"
        case family = "family"
        case image = "image"
        case imageUrl = "imageUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        family = try values.decodeIfPresent(String.self, forKey: .family)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
    }

}
