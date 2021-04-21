//
//  Preferences.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/13/21.
//


import RealmSwift



@objcMembers class UserPreferences: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var displayName: String?
    dynamic var avatarImage: Photo?

    var isEmpty: Bool { displayName == nil || displayName == "" }
}
