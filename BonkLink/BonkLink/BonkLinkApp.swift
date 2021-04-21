//
//  BonkLinkApp.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/13/21.
//

import SwiftUI
import RealmSwift
let app = RealmSwift.App(id: "bonklink-cytqk")

@main
struct BonkLinkApp: SwiftUI.App {
    @ObservedObject var state = SingletonVM.sharedInstance.globalViewModel
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
    }
}
