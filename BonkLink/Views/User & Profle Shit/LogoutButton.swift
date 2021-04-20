//
//  LogoutButton.swift
//  RChat
//
//  Created by Jacques Sarraffe on 4/20/420.//
import RealmSwift
import SwiftUI

struct LogoutButton: View {
     var state = SingletonVM.sharedInstance.globalViewModel
    @Environment(\.realm) var userRealm
    
    var action: () -> Void = {}
    
    var body: some View {
        Button("Log Out") {
//            logout()
            state.indicateActivity = true
            do {
                try userRealm.write {
                    state.user?.presenceState = .offLine
                }
            } catch {
                state.error = "Unable to open Realm write transaction"
            }
            
        }
  
    }
    
    private func logout() {
        action()
        app.currentUser?.logOut()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                state.indicateActivity = false
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
