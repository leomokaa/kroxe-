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
    var name: String = "Noname"
    var photo: Data?
    var link: String = "Nolink"
    var yarn: Int = 0
    var needle: Float = 0.0
    var text: String = "Notext"
    var counter: Int = 0
    var isFirstRecipe: Bool = false
    var timestamp: Date = Date()
    
    init(
        name: String,
        photo: Data? = nil,
        link: String,
        yarn: Int,
        needle: Float,
        text: String,
        counter: Int,
        isFirstRecipe: Bool,
        timestamp: Date = Date()
    ) {
        self.name = name
        self.photo = photo
        self.link = link
        self.yarn = yarn
        self.needle = needle
        self.text = text
        self.counter = counter
        self.isFirstRecipe = isFirstRecipe
        self.timestamp = timestamp
    }
}
