//
//  MessageModel.swift
//  ChatAI
//
//  Created by Manoj kumar on 23/12/22.
//

import Foundation

struct MessageModel: Codable {
    var message: String
    var isChatbot: Bool = true
}
