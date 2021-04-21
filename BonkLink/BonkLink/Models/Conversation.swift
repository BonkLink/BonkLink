//
//  Conversation.swift
//  BonkLink
//
//  Created by Brent Dunbar on 4/21/21.
//

import Foundation
import RealmSwift



@objcMembers class Conversation: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var id = UUID().uuidString
    dynamic var displayName = ""
    dynamic var unreadCount = 0
    //var members = List<Member>() //TODO member.swift
}
