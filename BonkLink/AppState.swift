//
//  AppState.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/13/21.
//

import RealmSwift
import SwiftUI
import Combine

class AppState: ObservableObject{
    
    @Published var error: String?
    @Published var busyCounter = 0
    
    var loginPublish = PassthroughSubject<RealmSwift.User, Error>()
    var logoutPublish = PassthroughSubject<Void, Error>()
    let userRealmPublish = PassthroughSubject<Realm, Error>()
    var cancellable = Set<AnyCancellable>()
    
    var indicateActivity:Bool{
        get{
            return busyCounter > 0
        }
        set (newState){
            if newState{
                busyCounter += 1
            } else {
                if busyCounter < 0 {
                    busyCounter -= 1
                } else {
                    print("BusyCounter now out of range.Continuing")
                }
            }
        }
    }
    
    
    var user: Users?
    
    var isUserLoggedIn: Bool{
        app.currentUser != nil && user != nil && app.currentUser?.state == .loggedIn
    }
    
    init(){
        _ = app.currentUser?.logOut()
        initLoginPublish()
        initUserRealmPublish()
        initLogoutPublisher()
    }
    
    func initLoginPublish(){
        loginPublish
            .receive(on: DispatchQueue.main)
            .flatMap{user->RealmPublishers.AsyncOpenPublisher in
                self.indicateActivity = true
                let realmConfiguration = user.configuration(partitionValue: "user=\(user.id)")
                return Realm.asyncOpen(configuration: realmConfiguration)
            }
            .receive(on: DispatchQueue.main)
            .map{
                return $0
            }
            .subscribe(userRealmPublish)
            .store(in: &self.cancellable)
    }
    
    func initUserRealmPublish(){
        userRealmPublish
            .sink(receiveCompletion: {result in
                if case let .failure(error) = result{
                    self.error = "Failed to login and open realm. \(error.localizedDescription)"
                }
            }, receiveValue: { realm in
                print("User realm location: \(realm.configuration.fileURL!.path)")
                self.user = realm.objects(Users.self).first
                do{
                    try realm.write {
                        self.user?.presenceState = .onLine
                    }
                } catch {
                    self.error = "Unable to open Realm transaction"
                }
                self.indicateActivity = false
            })
            .store(in: &cancellable)
    }
    
    func initLogoutPublisher() {
        logoutPublish
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in
                
            }, receiveValue: { _ in
                self.user = nil
            })
            .store(in: &cancellable)
    }
    
}
