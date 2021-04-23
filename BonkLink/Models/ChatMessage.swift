//
//  ChatMessage.swift
//  BonkLink
//
//  Created by Brent Dunbar on 4/21/21.
//

import Foundation
import RealmSwift

@objcMembers class ChatMessage: Object, ObjectKeyIdentifiable {
    dynamic var _id = UUID().uuidString
    dynamic var partition = ""
    dynamic var author: String?
    dynamic var text = ""
    dynamic var image: Photo?
    let location = List<Double>()
    dynamic var timestamp = Date()
    override static func primaryKey() -> String? {
        return "_id"
        
    }
    convenience init(author:String, test:String, image:Photo?, location:[Double] = []){
        self.init()
        self.author = author
        self.text = text
        self.image = image ?? nil
        location.forEach{ coord in
            self.location.append(coord)
        }
    }
    var conversationId: String{
        get { partition.components(separatedBy: "=")[1]}
        set(conversationId) { partition = "conversation=\(conversationId)"}
    }
    
}
extension ChatMessage: Identifiable {
    var id: String{_id}
}
