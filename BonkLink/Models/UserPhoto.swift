//
//  UserPhoto.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/13/21.
//

import RealmSwift
import SwiftUI

@objcMembers class Photo: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var _id = UUID().uuidString
    dynamic var thumbNail: Data?
    dynamic var picture: Data?
    dynamic var date = Date()
}
