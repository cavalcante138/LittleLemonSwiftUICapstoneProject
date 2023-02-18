//
//  LittleLemonSwiftUICapstoneProjectApp.swift
//  LittleLemonSwiftUICapstoneProject
//
//  Created by Lucas Cavalcante on 18/02/23.
//

import SwiftUI

@main
struct LittleLemonSwiftUICapstoneProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
