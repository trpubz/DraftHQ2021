//
//  DraftHQ2021App.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 3/15/21.
//

import SwiftUI

@main
struct DraftHQ2021App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(League())
        }
    }
}
