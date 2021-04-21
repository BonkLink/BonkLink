//
//  User.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/13/21.
//

import Foundation
import RealmSwift

@objcMembers class Users: Object, ObjectKeyIdentifiable {
    dynamic var _id = UUID().uuidString
    dynamic var partition = "" // "user=_id"
    dynamic var userName = ""
    dynamic var userPreferences: UserPreferences?
    dynamic var lastSeenAt: Date?
    var conversations = List<Conversation>()
    dynamic var presence = "Off-Line"

    var isProfileSet: Bool { !(userPreferences?.isEmpty ?? true) }
    var presenceState: Presence {
        get { return Presence(rawValue: presence) ?? .hidden }
        set { presence = newValue.asString }
    }

    override static func primaryKey() -> String? {
        return "_id"
    }
}

enum Presence: String {
    case onLine = "On-Line"
    case offLine = "Off-Line"
    case hidden = "Hidden"
    
    var asString: String {
        self.rawValue
    }
}
