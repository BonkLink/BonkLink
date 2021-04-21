//
//  LogoutButton.swift
//  RChat
//
//  Created by Jacques Sarraffe on 4/20/420.//
import RealmSwift
import SwiftUI

struct LogoutButton: View {
     var state = SingletonVM.sharedInstance.globalViewModel
//    @Environment(\.realm) var userRealm
    
    
    var body: some View {
        Button("Log Out") {
            state.indicateActivity = true
            if let realm = state.userRealm {
                do {
                    try realm.write {
                        state.user?.presenceState = .offLine
                    }
                } catch {
                    state.error = "Unable to open Realm write transaction"
                }
                logout()
            }
        }
        
        
    }
    
    private func logout() {
       
        app.currentUser?.logOut()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                state.indicateActivity = false
//                state.user?.presence = "Off-Line"
                state.logoutPublish.send($0)
            })
            .store(in: &state.cancellable)
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        AppearancePreviews(
            LogoutButton()
                
                .previewLayout(.sizeThatFits)
                .padding()
        )
    }
}
