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
    @EnvironmentObject var currState: AppState
    //Remind users after 12 hours that they're logged in!
    @AppStorage("remindUserOnline") var remindOnLineUser = false;
    @AppStorage("reminderUserHours") var remindHours = 12.0;
    @State var showProfile = false;
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    if(currState.isUserLoggedIn){
                        if(currState.user != nil) && (!currState.user!.isProfileSet || showProfile){
                            //Display Profile Here
                        }
                        else{
                            //Show Chatrooms list here
                            
                        }
                    }
                    //otherwise, user isn't logged in
                    else{
   
                
                    Login()
                    }
                    if let error = currState.error {
                              Text("Error: \(error)")
                                  .foregroundColor(Color.red)
                    }
                }
            }
        }
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





