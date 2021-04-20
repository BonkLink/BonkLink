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
     var currState = SingletonVM.sharedInstance.globalViewModel
    //Remind users after 12 hours that they're logged in!
    @AppStorage("remindUserOnline") var remindOnLineUser = false;
    @AppStorage("reminderUserHours") var remindHours = 12.0;
    @State var showProfile = false;
    var action: () -> Void = {}
    
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    if currState.isUserLoggedIn {
                        HStack{
                        Text("LOGGED")
                        LogoutButton()
                        }
                        
//                        if(currState.user != nil) && (!currState.user!.isProfileSet || showProfile){
//                            SetProfileView(isPresented: $showProfile)
//                               .environment(\.realmConfiguration,
//                                           app.currentUser!.configuration(partitionValue: "user=\(currState.user?._id ?? "")"))
//                        }
//                        else if(currState.user?.userName != nil){
//                            Text("Logged in with user profile set")
//                            LogoutButton();
//                            Button("checK"){
//                                print(app.currentUser?.id)
//                                action()
//                                app.currentUser?.logOut()
//                                    .receive(on: DispatchQueue.main)
//                                    .sink(receiveCompletion: { _ in
//                                    }, receiveValue: {
//                                        currState.indicateActivity = false
//                                        currState.logoutPublish.send($0)
//                                    })
//                                    .store(in: &currState.cancellable)
//                            }
//                        }
                    }
                    //otherwise, user isn't logged in
                    else{
   
                    Login()
                        Button("stater"){
                            print(currState.user?.userName)
                            print(currState.isUserLoggedIn)
                            currState.busyCounter = currState.busyCounter-1
                        }
                        Text(String(currState.busyCounter))
                    }
                    if let error = currState.error {
                              Text("Error: \(error)")
                                  .foregroundColor(Color.red)
                    }
                    
                }
                if currState.busyCounter > 1 {
                    Text("Working With Realm")
                }

                
            }
            
        }
        .currentDeviceNavigationViewStyle(alwaysStacked: !currState.isUserLoggedIn )

        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)){ _ in
            if let user = currState.user{
                if user.presenceState == .onLine && remindOnLineUser{
                    //Send Notification here!
                }
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for:UIApplication.willEnterForegroundNotification)){ _ in
            //Clear notifications here!
        }
    }
    
}

//addNotification() function
//clearNotificiation() function

extension View {
    public func currentDeviceNavigationViewStyle(alwaysStacked: Bool) -> AnyView {
        if UIDevice.current.userInterfaceIdiom == .pad && !alwaysStacked {
            return AnyView(self.navigationViewStyle(DefaultNavigationViewStyle()))
        } else {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
                ContentView()
            
    }
}





