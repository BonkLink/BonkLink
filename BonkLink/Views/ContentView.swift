//
//  ContentView.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/13/21.
//

import SwiftUI
import UserNotifications
import RealmSwift


struct ContentView: View {
    var body: some View {
        Login()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
