//
//  PitcherRow.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/12/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct PitcherRow: View {
    @ObservedObject var pitcher: Pitcher
    @State var rowState: PlayerRowState = .inline
    
    var body: some View {
        VStack {
            PitcherRowInline(pitcher: pitcher, rowState: $rowState)
            
            if rowState == .expanded {
                HStack {
                    ExpandedPlayerRow(plyr: pitcher, auctionPrice: pitcher.shekels, rowState: $rowState)
                    if pitcher.drafted {
                        Text("\(pitcher.name) drafted by \(pitcher.draftedTeam!.tmAbbrv)")
                    }
                    Spacer()
                }
            }
        }.animation(.default)
        
    }
}

struct PitcherRowInline: View {
    @ObservedObject var pitcher: Pitcher
    @Binding var rowState: PlayerRowState
    
    var body: some View {
        HStack {
            HStack {
                RowExpandButton(player: pitcher, rowState: self.$rowState)
                NameCol(name: pitcher.name)
                TeamCol(team: pitcher.mlbTeam)
                PosCol(strPos: pitcher.strPos)
                AVCol(av: "₪ \(Int(pitcher.shekels))") //converts to int for automatic rounding
                StatCol(stat: "\(String(format: "%.1f", pitcher.wFIP))")
            }
            HStack {
                StatCol(stat: "\(pitcher.IP)")
                StatCol(stat: "₪ \(Int(pitcher.vIP))")
                StatCol(stat: "\(pitcher.QS)")
                StatCol(stat: "₪ \(Int(pitcher.vQS))")
                StatCol(stat: "\(pitcher.SVHD)")
                StatCol(stat: "₪ \(Int(pitcher.vSVHD))")
            }
            HStack {
                StatCol(stat: formattedStat(forPIT: pitcher.ERA))
                StatCol(stat: "₪ \(Int(pitcher.vERA))")
                StatCol(stat: formattedStat(forPIT: pitcher.WHIP))
                StatCol(stat: "₪ \(Int(pitcher.vWHIP))")
                StatCol(stat: formattedStat(forPIT: pitcher.Kp9))
                StatCol(stat: "₪ \(Int(pitcher.vKp9))")
            }
        }
        .foregroundColor(pitcher.drafted ? .gray : .primary)
    }
}

struct RLPPitcherRow: View {
    let pos: POS
    var rlp: RLPPitcher {
        switch pos {
        case .SP: return league.allSP[0].rlp
        case .RP: return league.allRP[0].rlp
        default:
            print("wont print this")
            return league.allSP[0].rlp
        }
    }
    
    var body: some View {
        HStack {
            HStack {
                Text("").frame(width: 33.0)
                NameCol(name: "RLP")
                TeamCol(team: "FA")
                PosCol(strPos: rlp.pos.rawValue)
                AVCol(av: "₪ --") //converts to int for automatic rounding
                StatCol(stat: "\(String(format: "%.1f", rlp.wFIP))")
            }
            HStack {
                StatCol(stat: "\(rlp.IP)")
                StatCol(stat: "₪ --")
                StatCol(stat: "\(rlp.QS)")
                StatCol(stat: "₪ --")
                StatCol(stat: "\(rlp.SVHD)")
                StatCol(stat: "₪ --")
            }
            HStack {
                StatCol(stat: formattedStat(forPIT: rlp.ERA))
                StatCol(stat: "₪ --")
                StatCol(stat: formattedStat(forPIT: rlp.WHIP))
                StatCol(stat: "₪ --")
                StatCol(stat: "\(String(format: "%.2f", rlp.Kp9))")
                StatCol(stat: "₪ --")
            }
        }
    }
}

struct PitcherRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PitcherHeaderRow()
            ScrollView {
                
                PitcherRow(pitcher: league.pitchers.first(where: {$0.name == "Jacob deGrom"})!, rowState: .inline)
                
            }
            .frame(width: 980)
            .listStyle(SidebarListStyle())
            
            RLPPitcherRow(pos: .SP)
        }
        
    }
}
