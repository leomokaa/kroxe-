//
//  Forms.swift
//  kroxê
//
//  Created by User on 23/04/26.
//

import SwiftData
import PhotosUI

@Model
class Recipe {
    var id = UUID()
    var name: String
    var photo: Data?
    var link: String?
    var yarn: Int
    var needle: Float
    var text: String
    
    init(
        name: String,
        photo: Data? = nil,
        link: String? = nil,
        yarn: Int,
        needle: Float,
        text: String
    ) {
        self.name = name
        self.photo = photo
        self.link = link
        self.yarn = yarn
        self.needle = needle
        self.text = text
    }
}
