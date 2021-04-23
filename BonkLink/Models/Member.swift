//
//  Member.swift
//  BonkLink
//
//  Created by Brent Dunbar on 4/21/21.
//

import Foundation
import RealmSwift

@objcMembers class Member: EmbeddedObject,ObjectKeyIdentifiable {
    
    
    dynamic var userName = ""
    dynamic var membershipStatus: String = "Pending"
    
    convenience init(_ userName: String){
        self.init()
        self.userName = userName
        membershipState = .pending
        

    }

    convenience init(userName: String, state: MembershipStatus){
        self.init()
        self.userName = userName
        membershipState = state
    
    }
    
    var membershipState: MembershipStatus{
        get { return MembershipStatus(rawValue: membershipStatus) ?? .left}
        set {membershipStatus = newValue.asString}
    
    }
    
}

enum MembershipStatus: String {
    case pending = "Pending"
    case invited = "invited"
    case active = "Active"
    case left = "Left"
    

    var asString: String {
        self.rawValue
    }
    
}
