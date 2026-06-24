//
//  AppDelegate.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import SwiftUI
import FirebaseCore

@main
struct StrangequizzApp: App {

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
