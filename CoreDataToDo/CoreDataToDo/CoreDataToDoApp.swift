//
//  CoreDataToDoApp.swift
//  CoreDataToDo
//
//  Created by Tatu Ketomaa on 31.1.2022.
//

import SwiftUI

@main
struct CoreDataToDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
