//
//  NYTTestTaskApp.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import SwiftUI
import RealmSwift

@main
struct NYTTestTaskApp: SwiftUI.App {
    init() {
            // Migration
            let config = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 1 {
                        // Nothing to do!
                    }
                }
            )

            // Set the configuration
            Realm.Configuration.defaultConfiguration = config

            // Try to open the Realm
            do {
                _ = try Realm()
            } catch {
                print("Error initializing Realm: \(error)")
            }
        }
    
    var body: some Scene {
        WindowGroup {
            CategoriesView()
        }
    }
}
