//
//  Forms.swift
//  kroxê
//
//  Created by User on 23/04/26.
//


import Foundation
import SwiftData
import PhotosUI

@Model class recipe {
    var name: String
    //      var image: UIImage?    //por favor, não mexer
    var link: String?
    var yarn: Int
    var needle: Float
    var text: String
    
    init(
        name: String,
        //        image: UIImage? = nill
        link: String? = nil,
        yarn: Int,
        needle: Float,
        text: String
    ) {
        self.name = name
        //        self.image = image
        self.link = link
        self.yarn = yarn
        self.needle = needle
        self.text = text
    }
}
