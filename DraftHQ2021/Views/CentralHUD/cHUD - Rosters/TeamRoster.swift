//
//  TeamRoster.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/19/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct TeamRoster: View {
    @ObservedObject var team: Team
    
    var body: some View {
        
        VStack {
            HStack {
                Text(team.tmAbbrv + " - " + team.owner)
                    .font(.subheadline)
                    .fontWeight(.thin)
            }
            Text(team.teamName)
                .font(.subheadline)

            VStack {
                Text("---STICKS---")
                    .font(.subheadline)
                HStack {
                    //roster slots
                    VStack {
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .C}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .IF1B}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .IF2B}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .IF3B}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .SS}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .OF1}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .OF2}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .OF3}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .DH}))
                    }
                    //offense stats
                    StatLinesHIT(team: self.team)
                    
                }
                
            }
            VStack {
                Text("---ARMS---")
                    .font(.subheadline)
                HStack {
                    VStack {
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .SP1}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .SP2}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .SP3}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .SP4}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .P1}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .RP1}))
                        RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .RP2}))
                    }
                    StatLinesPIT(team: self.team)
                }
                
            }
            VStack {
                Text("---BENCH---")
                    .font(.subheadline)
                RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .BN1}))
                RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .BN2}))
                RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .BN3}))
                RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .BN4}))
                RostersTabPlayerRow(rosterSlot: team.roster.first(where: {$0.key == .BN5}))
            }
        }
        .padding(.all)
        .background(Color.accentColor.opacity(0.75))
        .cornerRadius(16)
        
    }
}

struct StatLinesHIT: View {
    @ObservedObject var team: Team
    
    var body: some View {
        VStack(alignment: .leading) {
            StatLine(category: "HR", stat: NSNumber(value: team.totHR))
            StatLine(category: "R", stat: NSNumber(value: team.totR))
            StatLine(category: "RBI", stat: NSNumber(value: team.totRBI))
            StatLine(category: "NSB", stat: NSNumber(value: team.totNSB))
            StatLine(category: "OBP", stat: NSNumber(value: team.totOBP))
            StatLine(category: "SLG", stat: NSNumber(value: team.totSLG))
        }
    }
}

struct StatLinesPIT: View {
    @ObservedObject var team: Team
    
    var body: some View {
        VStack(alignment: .leading) {
            StatLine(category: "IP", stat: NSNumber(value: team.totIP))
            StatLine(category: "QS", stat: NSNumber(value: team.totQS))
            StatLine(category: "SVHD", stat: NSNumber(value: team.totSVHD))
            StatLine(category: "ERA", stat: NSNumber(value: team.totERA))
            StatLine(category: "WHIP", stat: NSNumber(value: team.totWHIP))
            StatLine(category: "K/9", stat: NSNumber(value: team.totKp9))
        }
    }
}

struct StatLine: View {
    var category: String
    var stat: NSNumber
    
    var body: some View {
        HStack {
            Text("\(category): ")
                .frame(width: 40, alignment: .leading)
            Text("\(stat)")
                .frame(width: 40)
                .lineLimit(1)
        }
    }
}

struct TeamRoster_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TeamRoster(team: League().teams[2])
            Divider().padding(.vertical)
            TeamRoster(team: League().teams[5])
        }
    }
}
