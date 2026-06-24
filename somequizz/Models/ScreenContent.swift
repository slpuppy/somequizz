//
//  ScreenContent.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

struct ButtonContent: Codable {
    var title: String
}

struct ImageContent: Codable {
    var url: String
}

struct ScreenContent: Codable {
    var title: String?
    var subtitle: String?
    var label1: String?
    var label2: String?
    var label3: String?
    var label4: String?
    var label5: String?
    var buttons: [ButtonContent]?
    var images: [ImageContent]?
}
