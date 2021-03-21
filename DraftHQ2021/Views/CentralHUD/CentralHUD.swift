//
//  CentralHUD.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/10/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

//tabbed view
struct CentralHUD: View {
    @State private var currentTab: selectedTab = .players
    
    var body: some View {
        TabView(selection: $currentTab) {
            PlayersHUD()
                .onTapGesture {
                    self.currentTab = .players
                }
                .tabItem {
                    Text("Players HUD")
                }
                .tag(selectedTab.players)
            RostersHUD()
                .onTapGesture {
                    self.currentTab = .rosters
                }
                .tabItem({
                    Text("League Rosters")
                })
                .tag(selectedTab.rosters)
            StandingsView()
                .tabItem({
                    Text("Standings")
                    
                })
                .tag(selectedTab.standings)
        }.frame(minWidth: 965)
        
    }
}

enum imgTabs: String {
    case homeStock, homeHover
    case groupStock, groupHover
}

enum selectedTab {
    case players, rosters, standings
}

struct CentralHUD_Previews: PreviewProvider {
    static var previews: some View {
        CentralHUD()
            .environmentObject(League())
            .frame(width: 965, height: 700)
    }
}
