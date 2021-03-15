//
//  RostersHUD.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/19/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct RostersHUD: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    TeamRoster(team: league.teams[1])
                    TeamRoster(team: league.teams[2])
                    TeamRoster(team: league.teams[3])
                }
                HStack {
                    TeamRoster(team: league.teams[4])
                    TeamRoster(team: league.teams[5])
                    TeamRoster(team: league.teams[6])
                }
                HStack {
                    TeamRoster(team: league.teams[7])
                    TeamRoster(team: league.teams[8])
                    TeamRoster(team: league.teams[9])
                }
                HStack {
                    TeamRoster(team: league.teams[10])
                    TeamRoster(team: league.teams[11])
                    
                }
            }
        }
        
    }
}

struct RostersHUD_Previews: PreviewProvider {
    static var previews: some View {
        RostersHUD()
    }
}
