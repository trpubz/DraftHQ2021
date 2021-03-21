//
//  RostersHUD.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/19/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct RostersHUD: View {
    @EnvironmentObject var league: League
    let columns = [
        GridItem(spacing: 10, alignment: .center),
        GridItem(spacing: 10, alignment: .center),
        GridItem(spacing: 10, alignment: .center)
    ]
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                ForEach(league.teams.indices) { tm in
                    TeamRoster(team: league.teams[tm])
                }
            }
            // depricated
//           VStack(spacing: 10) {
//                HStack(spacing: 10) {
//                    TeamRoster(team: league.teams[1])
//                    TeamRoster(team: league.teams[2])
//                    TeamRoster(team: league.teams[3])
//                }
//                HStack {
//                    TeamRoster(team: league.teams[4])
//                    TeamRoster(team: league.teams[5])
//                    TeamRoster(team: league.teams[6])
//                }
//                HStack {
//                    TeamRoster(team: league.teams[7])
//                    TeamRoster(team: league.teams[8])
//                    TeamRoster(team: league.teams[9])
//                }
//                HStack {
//                    TeamRoster(team: league.teams[10])
//                    TeamRoster(team: league.teams[11])
//
//                }
//            }
        }
        
    }
}

struct RostersHUD_Previews: PreviewProvider {
    static var previews: some View {
        RostersHUD()
            .environmentObject(League())
    }
}
