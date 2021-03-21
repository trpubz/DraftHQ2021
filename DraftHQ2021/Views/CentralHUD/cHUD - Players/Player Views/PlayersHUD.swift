//
//  PlayersHUD.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/19/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct PlayersHUD: View {
    @EnvironmentObject var league: League
    @State var filter: POS = .OF
    var playerPool: [Player] {
        switch filter {
        case .OF: return Array(league.allOF.prefix(45))
        case .C: return Array(league.allC.prefix(15))
        case .IF1B: return Array(league.all1B.prefix(15))
        case .IF2B: return Array(league.all2B.prefix(15))
        case .IF3B: return Array(league.all3B.prefix(15))
        case .SS: return Array(league.allSS.prefix(15))
        case .DH: return Array(league.allDH.prefix(15))
        case .SP: return Array(league.allSP.prefix(65))
        case .RP: return Array(league.allRP.prefix(30))
        case .LBN:
            print("probs not gonna print")
            return Array(league.allOF.prefix(36))
        }
    } //determines the number of players to show per position
    
    var body: some View {
        VStack {
            SearchView()
            //position picker section
            HStack {
                Picker(selection: $filter, label: Text("Position Filter:")) {
                    Text("DH").tag(POS.DH)
                    Text("C").tag(POS.C)
                    Text("1B").tag(POS.IF1B)
                    Text("2B").tag(POS.IF2B)
                    Text("3B").tag(POS.IF3B)
                    Text("SS").tag(POS.SS)
                    Text("OF").tag(POS.OF)
                    Text("SP").tag(POS.SP)
                    Text("RP").tag(POS.RP)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 500)
            }

            if filter == .SP || filter == .RP {
                PitcherHeaderRow()
            } else {
                HitterHeaderRow()
            }
            //players section
            ScrollView {
                if filter == .SP || filter == .RP {
                    ForEach(playerPool) { p in
                        PitcherRow(pitcher: p as! Pitcher)
                    }
                } else {
                    ForEach(playerPool) { h in
                        HitterRow(hitter: h as! Hitter)
                    }
                }
            }
            // changes the replacement lvl player footer based on pos
            Divider()
            if filter == .SP || filter == .RP {
                RLPPitcherRow(pos: filter)
            } else {
                RLPHitterRow(pos: filter)
            }
        }
        .frame(width: 965.0)
    }
}

struct PlayersHUD_Previews: PreviewProvider {
    static var previews: some View {
        PlayersHUD()
            .environmentObject(League())
    }
}
