//
// Created by Utsman on 28/3/20.
// Copyright (c) 2020 utsman. All rights reserved.
//

import Foundation

struct Url: Codable {
    var small: String
    var regular: String
}

struct Unsplash: Codable, Identifiable {
    var id: String
    var urls: Url
}

struct Search: Codable {
    var results: [Unsplash]
}