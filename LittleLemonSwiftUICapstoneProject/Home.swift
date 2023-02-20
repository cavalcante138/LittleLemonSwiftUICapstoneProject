//
//  Home.swift
//  LittleLemonSwiftUICapstoneProject
//
//  Created by Lucas Cavalcante on 19/02/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        let persistence = PersistenceController.shared
        
        TabView {
            Menu()
                 .tabItem {
                     Label("Menu", systemImage: "list.dash")
                 }
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .environment(\.managedObjectContext, persistence.container.viewContext)
        .navigationBarBackButtonHidden(true) 
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
