//
//  Onboarding.swift
//  Restaurant
//
//  Created by Mac on 13/08/2023.
//

import SwiftUI

/*
 They will be used as the keys in UserDefaults to store and access the first name, last name and email of the user
 */

let kFirstName = "first name key"
let kLastName = "first name key"
let kEmail = "first name key"

let kIsLoggedIn = "kIsLoggedIn"


struct Onboarding: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                
                TextField("First Nmae", text: $firstName)
                
                TextField("Last Nmae", text: $lastName)
                TextField("Email", text: $email)
                
                Button("Register", action:{
                    
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty  {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        // Navigate to Home screen or perform other actions
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    }
                  
                           
                      
                    
                    
                })
                
                NavigationLink(
                                  destination: Home(isLoggedIn: $isLoggedIn),
                                  isActive: $isLoggedIn
                              ) {
                                  EmptyView()
                              }
                
                Button("Log In") {
                    if !firstName.isEmpty && !lastName.isEmpty {
                        isLoggedIn = true
                    }
                }
                .padding()
                
                
                .onAppear {
                         if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                             isLoggedIn = true
                         }
                     }
            }
            
        }// end navigation
    }
}




struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
