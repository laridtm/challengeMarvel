//
//  ComicList.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import Foundation

struct ComicList: Codable {
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [ComicSummary]
}

