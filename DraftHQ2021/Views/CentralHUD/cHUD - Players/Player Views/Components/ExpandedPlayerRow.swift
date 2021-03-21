//
//  ExpandedPlayerRow.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/15/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct ExpandedPlayerRow: View {
    @EnvironmentObject var league: League
    var plyr: Player
    @State var auctionPrice: Double = 1
    @State var team: String = ""
    @Binding var rowState: PlayerRowState
    
    var body: some View {

        HStack {
            Picker("Team", selection: $team) {
                ForEach(league.teams) { tm in
                    Text(tm.tmAbbrv).tag(tm.tmAbbrv)
                }
            }
            .frame(width: 120.0)
            
            VStack(spacing: 0.1) {
                // depricated 21 MAR 2021
//                Text("Auction Price: ₪ \(Int(auctionPrice))")
//                    .frame(width: 150.0)
//                Slider(value: $auctionPrice, in: 1...99)
//                    .frame(width: 125.0)
                Stepper("Auction Price: ₪ \(Int(auctionPrice))", value: $auctionPrice, in: 1...116)
                    
                    .frame(width: 150, height: 30)
            }
            .padding()
            .frame(width: 150)
            
//            Text("Auction Price: ₪ ")
//            TextField("₪AV", value: $auctionPrice, formatter: NumberFormatter.shekels)
//                .frame(width: 26.0)
            Button(action: {
                self.plyr.drafted = true
                self.rowState = .inline
//                    print("\(self.team) drafted \(self.hitter.name) for ₪\( self.auctionPrice)")
                league.playerDrafted(self.plyr, by: league.teams.first(where: {$0.tmAbbrv == self.team})!, forShek: Int(self.auctionPrice))
            }) {
                Text("Draft!")
            }
            //perhaps list each category rankings
            //perhaps calculate which team would benefit most/least from drafting the player
        }
        .padding()
        .frame(width: 400.0, height: 75)
        .border(Color.accentColor, width: 3)
        .cornerRadius(3)
            

            
        
    }
}

struct ExpandedPlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedPlayerRow(plyr: League().hitters[0], rowState: .constant(.expanded))
            .environmentObject(League())
    }
}

enum PlayerRowState: String {
    case inline, expanded
}
