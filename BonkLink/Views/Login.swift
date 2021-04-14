//
//  Login.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/14/21.
//

import SwiftUI
import RealmSwift

struct Login: View {
    
    @EnvironmentObject var state: AppState
    
    @State private var userName = ""
    @State private var password = ""
    @State private var newUser = false
    
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
