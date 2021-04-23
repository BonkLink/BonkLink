//
//  Login.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/14/21.
//

import SwiftUI
import RealmSwift

struct Login: View {
    
     var state = SingletonVM.sharedInstance.globalViewModel
    
    @State private var userName = ""
    @State private var password = ""
    @State private var newUser = false
    
    @State var signup = false
    
    
    
    var body: some View {
        VStack(spacing: 15) {
            Text("BonkLink")
                .font(.largeTitle).foregroundColor(Color.black)
                .padding([.top, .bottom], 40)
            HStack() {
                VStack{
                    Text("Username")
                        .padding(.bottom, -7.0)
                        
                TextField("Username", text: self.$userName)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .disableAutocorrection(true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.black, lineWidth: 2)
                            .frame(height: 35.0)
                            )
                .padding()
                .cornerRadius(20.0)
                }
                VStack{
                    Text("Password")
                        
                        
                        .padding(.bottom, -7.0)
            SecureField("Password", text: self.$password)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.black, lineWidth: 2)
                        .frame(height: 35.0)
                        )
                .foregroundColor(.white)
                .padding()
                .cornerRadius(20.0)
                }
            }
            
            HStack() {
          
                Button(action: {if(state.user == nil){self.userActionLogin(userName: userName, password: password)}}){
                    Text("Sign In")
                      .font(.headline)
                      .foregroundColor(.white)
                        
                      .padding()
                        
                      .frame(width: 150, height: 50)
                      .background(Color.green)
                      .cornerRadius(15.0)
                    
                }

             
                Button(action: {
                    self.signupUser(userName: userName, passwd: password)
                }) {
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
                        maxHeight: .infinity)

        .background(
          LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .navigationBarHidden(true)

//        if signup {
//            Text("YEP!")
//                .transition(.slide)
//        }
        }
    
    
    
    func signupUser(userName: String, passwd: String){
        if userName.isEmpty || passwd.isEmpty{
            self.state.indicateActivity = false
            return
        }
        self.state.error = nil
        app.emailPasswordAuth.registerUser(email: userName, password: passwd)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                self.state.indicateActivity = false
                switch $0 {
                case .finished:
                    break
                case .failure(let error):
                    self.state.error = error.localizedDescription
                }
            }, receiveValue: {
                self.state.error = nil
                print("Successful register!")
                login(username: userName, passwd: passwd)
            })
            .store(in: &state.cancellable)
    }
    
    
    
    
    func userActionLogin(userName: String, password: String){
        self.state.indicateActivity = true;
        login(username: userName, passwd: password)
        
        print(state.user)
    }
    
    
    func login(username: String, passwd: String){
        if username.isEmpty || passwd.isEmpty{
            self.state.indicateActivity = false
            return
        }
        self.state.error = nil
        app.login(credentials: .emailPassword(email: username, password: passwd))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                self.state.indicateActivity = false
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    self.state.error = error.localizedDescription
                }
            }, receiveValue: {
                self.state.error = nil
                self.state.loginPublish.send($0)
            })
            .store(in: &state.cancellable)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
                Login()
    }
}
