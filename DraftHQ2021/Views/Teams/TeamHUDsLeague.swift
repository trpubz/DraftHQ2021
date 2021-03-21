//
//  TeamHUDsLeague.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 3/19/21.
//

import SwiftUI

// This view is on the main HUD, left hand column
struct TeamHUDsLeague: View {
    @EnvironmentObject var league: League
    
    var body: some View {
        ScrollView{
            ForEach(league.teams.sorted(by: {$0.tmW > $1.tmW}), id: \.id) {tm in
                TeamHUD(team: tm)
                Divider().padding(.horizontal)
            }
        }
        .frame(width: 350, height: 600)
    }
}

struct TeamHUDsLeague_Previews: PreviewProvider {
    
    static var previews: some View {
        TeamHUDsLeague()
            .environmentObject(League())
    }
}
