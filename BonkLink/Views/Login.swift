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
        VStack(spacing: 15) {
            Text("BonkLink")
                .font(.largeTitle).foregroundColor(Color.black)
                .padding([.top, .bottom], 40)
            HStack() {
            TextField("Username", text: self.$userName)
                .padding()
                .cornerRadius(20.0)
            SecureField("Password", text: self.$password)
                .padding()
                .cornerRadius(20.0)
            }
            HStack() {
                Button(action: {}){
                    Text("Sign In")
                      .font(.headline)
                      .foregroundColor(.white)
                      .padding()
                      .frame(width: 150, height: 50)
                      .background(Color.green)
                      .cornerRadius(15.0)
                }
                Button(action: {}) {
                    Text("Sign-Up")
                      .font(.headline)
                      .foregroundColor(.white)
                      .padding()
                      .frame(width: 150, height: 50)
                      .background(Color.blue)
                      .cornerRadius(15.0)
                }
            }
        }
        .frame(minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity
                )
        .background(
          LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
