//
//  Character.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let modified: Date
    let thumbnail: Image
    let comics: ComicList
}
