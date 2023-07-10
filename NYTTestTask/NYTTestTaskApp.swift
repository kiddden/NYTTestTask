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
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 3 {
//                    migration.enumerateObjects(ofType: Book.className()) { oldObject, newObject in
//                        if let oldID = oldObject!["_id"] as? ObjectId {
//                            newObject!["id"] = oldID.stringValue // Convert ObjectId to String
//                        }
//                    }
                }
            }
        )
        
        Realm.Configuration.defaultConfiguration = config
        
        do {
            let realm = try Realm()
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
