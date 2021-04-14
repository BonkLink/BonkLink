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
    @StateObject var state = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)
        }
    }
}
