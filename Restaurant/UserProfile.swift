//
//  UserProfile.swift
//  Restaurant
//
//  Created by Mac on 13/08/2023.
//

import SwiftUI

struct UserProfile: View {
    
    let firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
        let lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
        let email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    // This will automatically reference the presentation environment in SwiftUI which will allow you to reach the navigation logic.
    @Environment(\.presentationMode) var presentation

    var body: some View {
        
        VStack{
            
            Text("Personal information")
            Image("profile-image-placeholder")
            
            Text(firstName)
            Text(lastName)
            Text(email)
            Button("Logout"){
                UserDefaults.standard.set(false, forKey: kIsLoggedIn) // Set to false
                              presentation.wrappedValue.dismiss() // Dismiss the view
            }
            Spacer()
        }//end stack
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
