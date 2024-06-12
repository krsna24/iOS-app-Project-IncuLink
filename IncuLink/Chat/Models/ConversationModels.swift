//
//  ConversationModels.swift
//  IncuLink
//
//  Created by Ankit Rajput on 06/06/24.
//

import Foundation

struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
