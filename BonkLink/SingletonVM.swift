//
//  SingletonVM.swift
//  BonkLink
//
//  Created by Guy Greenleaf on 4/19/21.


import Foundation

class SingletonVM: ObservableObject{
    
    static var sharedInstance = SingletonVM()
    
    init(){}
    
    @Published var globalViewModel = AppState()
    
    static var shareReset:SingletonVM {
       return self.sharedInstance
    }
}
