//
//  Comic.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 29/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation

struct Comic: Codable {
    let id: Int?
    let title: String?
    let thumbnail: Image?
    
    func getComicImage() -> String {
        guard let urlPath = thumbnail?.path else { return "" }
        guard let urlExt = thumbnail?.ext else { return "" }
        let urlImage = "\(urlPath)/portrait_xlarge.\(urlExt)"
        return urlImage
    }
}
