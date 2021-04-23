//
//  Chatter.swift
//  BonkLink
//
//  Created by Brent Dunbar on 4/21/21.
//

import Foundation
import RealmSwift

@objcMembers class Chatter: Object, ObjectKeyIdentifiable {
    dynamic var _id = UUID().uuidString
    dynamic var partition = "all-users=all-the-users"
    dynamic var UserName = ""
    dynamic var displayName: String?
    dynamic var avatarImage: Photo?
    dynamic var lastSeenAt: Date?
    dynamic var presence = "Off-Line"
    var presenceState: Presence {
        get { return Presence(rawValue: presence) ?? .hidden}
        set { presence = newValue.asString}
        
    }
    override static func primaryKey() -> String? {
        return "_id"
    }
    
}
