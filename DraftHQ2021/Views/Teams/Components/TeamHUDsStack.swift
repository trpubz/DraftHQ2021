//
//  TeamHUDs.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 4/17/20.
//  Copyright © 2020 trpubz. All rights reserved.
//  Depricated on 20 MAR 2021 - trp

import SwiftUI

// This view is on the main HUD, left hand column
struct TeamHUDsStack: View {
    @EnvironmentObject var league: League
    @State var hoverState = false
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 1) {
                TeamHUD(team: league.teams[1])
                    
                Divider().padding(.horizontal)
                TeamHUD(team: league.teams[2])
                Divider().padding(.horizontal)
                TeamHUD(team: league.teams[3])
                Divider().padding(.horizontal)
                TeamHUD(team: league.teams[4])
                Divider().padding(.horizontal)
                TeamHUD(team: league.teams[5])
                Divider().padding(.horizontal)
            }
            VStack(alignment: .center, spacing: 1) {
                TeamHUD(team: league.teams[6])
                Divider().padding(.horizontal)
                TeamHUD(team: league.teams[7])
                Divider().padding(.horizontal)
                TeamHUD(team: league.teams[8])
                Divider().padding(.horizontal)
            }
            VStack(alignment: .center, spacing: 1) {
                TeamHUD(team: league.teams[9])
                Divider().padding(.horizontal)
                TeamHUD(team: league.teams[10])
                Divider().padding(.horizontal)
                TeamHUD(team: league.teams[11])
            }

        }
        .frame(width: 350)
    }
}

struct TeamHUDsStack_Previews: PreviewProvider {
    
    static var previews: some View {
        TeamHUDsStack()
            .environmentObject(League())
        
//        TeamHUDs(team: Team(tmAbbrv: "PUBE", teamName: "Magic Loogies", owner: "T. Pubins"))
    }
}
