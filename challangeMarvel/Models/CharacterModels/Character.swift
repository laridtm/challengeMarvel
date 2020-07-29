//
//  Character.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: Image?
    let comics: ComicList?
    
    init(id: Int?, name: String?, description: String?, modified: String?, thumbnail: Image?, comics: ComicList?) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
        self.comics = comics
    }
    
    func getCharacterImage() -> String {
        guard let urlPath = thumbnail?.path else { return "" }
        guard let urlExt = thumbnail?.ext else { return "" }
        let urlImage = "\(urlPath)/portrait_xlarge.\(urlExt)"
        return urlImage
    }
}
