//
//  Home.swift
//  Restaurant
//
//  Created by Mac on 13/08/2023.
//

import SwiftUI

struct Home: View {
    @Binding var isLoggedIn: Bool
    let persistence = PersistenceController.shared // Declare and initialize

    var body: some View {
        TabView{
            Menu()
                           .tabItem {
                               Label("Menu", systemImage: "list.dash")
                           }
                           .navigationBarBackButtonHidden(true)
            
            
            
            Menu().tabItem {Label("Profile", systemImage: "square.and.pencil")}
        }
        .environment(\.managedObjectContext, persistence.container.viewContext) // Set managed object context




    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(isLoggedIn: .constant(true))
    }
}
