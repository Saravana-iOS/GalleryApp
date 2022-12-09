//
//  ImageModel.swift
//  NASAGalleryApp
//
//  Created by Saravana kumar on 09/12/22.
//

import Foundation

struct ImageModel {
    var title : String
    var explanation : String
    var mediaType : String
    var url : String
    var hdurl : String
    var date : String
    var copyrights : String
    var serviceVersion : String

    enum CodingKeys: String, CodingKey {
        case title
        case explanation
        case mediaType = "media_type"
        case url
        case hdurl
        case date
        case copyrights
        case serviceVersion = "service_version"
    }
    
}

extension ImageModel : Decodable {
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        explanation = try values.decodeIfPresent(String.self, forKey: .explanation) ?? ""
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType) ?? ""
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        hdurl = try values.decodeIfPresent(String.self, forKey: .hdurl) ?? ""
        date = try values.decodeIfPresent(String.self, forKey: .date) ?? ""
        copyrights = try values.decodeIfPresent(String.self, forKey: .copyrights) ?? ""
        serviceVersion = try values.decodeIfPresent(String.self, forKey: .serviceVersion) ?? ""

    }
}
