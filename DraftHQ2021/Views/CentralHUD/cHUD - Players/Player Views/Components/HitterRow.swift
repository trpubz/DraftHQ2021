//
//  HitterRow.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/4/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI
import Foundation

struct HitterRow: View {
    @ObservedObject var hitter: Hitter
    @State var rowState: PlayerRowState = .inline
    
    var body: some View {
        VStack(alignment: .center) {
            HitterRowInline(hitter: hitter, rowState: $rowState)
            
            if rowState == .expanded {
                HStack {
                    ExpandedPlayerRow(plyr: hitter, auctionPrice: hitter.shekels, rowState: $rowState)
                    if hitter.drafted {
                        Text("\(hitter.name) drafted by \(hitter.draftedTeam!.tmAbbrv)")
                    }
                    Spacer()
                }
                
            }
        }.animation(.default)
        
    }
}

struct HitterRowInline: View {
    @ObservedObject var hitter: Hitter
    @Binding var rowState: PlayerRowState
    
    var body: some View {
        HStack {
            HStack {
                RowExpandButton(player: hitter, rowState: $rowState)
                NameCol(name: hitter.name)
                TeamCol(team: hitter.mlbTeam)
                PosCol(strPos: hitter.strPos)
                AVCol(av: "₪ \(Int(hitter.shekels))") //converts to int for automatic rounding
                StatCol(stat: "\(String(format: "%.1f", hitter.wRAA))")
            }
            HStack {
                StatCol(stat: "\(hitter.HR)").foregroundColor(hitter.drafted ? .gray : .primary)
                StatCol(stat: "₪ \(Int(hitter.vHR))")
                StatCol(stat: "\(hitter.R)")
                StatCol(stat: "₪ \(Int(hitter.vR))")
                StatCol(stat: "\(hitter.RBI)")
                StatCol(stat: "₪ \(Int(hitter.vRBI))")
                StatCol(stat: "\(hitter.NSB)")
                StatCol(stat: "₪ \(Int(hitter.vNSB))")
            }
            HStack {
                StatCol(stat: formattedStat(forHIT: hitter.OBP))
                StatCol(stat: "₪ \(Int(hitter.vOBP))")
                StatCol(stat: formattedStat(forHIT: hitter.SLG))
                StatCol(stat: "₪ \(Int(hitter.vSLG))")
            }
        }
        .foregroundColor(hitter.drafted ? .gray : .primary)
        //.saturation(hitter.drafted ? -3 : 1)
    }
}



struct RLPHitterRow: View {
    @EnvironmentObject var league: League
    let pos: POS
    var rlp: RLPHitter {
        switch pos {
        case .C: return league.allC[0].rlp
        case .IF1B: return league.all1B[0].rlp
        case .IF2B: return league.all2B[0].rlp
        case .IF3B: return league.all3B[0].rlp
        case .SS: return league.allSS[0].rlp
        case .OF: return league.allOF[0].rlp
        case .DH: return league.allDH[0].rlp
        default:
            print("wont print this")
            return league.allOF[0].rlp
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
                StatCol(stat: "\(String(format: "%.1f", rlp.wRAA))")
            }
            HStack {
                StatCol(stat: "\(rlp.HR)")
                StatCol(stat: "₪ --")
                StatCol(stat: "\(rlp.R)")
                StatCol(stat: "₪ --")
                StatCol(stat: "\(rlp.RBI)")
                StatCol(stat: "₪ --")
                StatCol(stat: "\(rlp.NSB)")
                StatCol(stat: "₪ --")
            }
            HStack {
                StatCol(stat: formattedStat(forHIT: rlp.OBP))
                StatCol(stat: "₪ --")
                StatCol(stat: formattedStat(forHIT: rlp.SLG))
                StatCol(stat: "₪ --")
            }
        }
    }
}



struct HitterRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HitterHeaderRow()
            ScrollView {
                
                HitterRow(hitter: League().hitters.first(where: {$0.name == "Jeff McNeil"})!)
//                HitterRowExpanded(hitter: league.hitters[0], rowState: .constant(.expanded))
            }

                .frame(width: 980)
                .listStyle(SidebarListStyle())
            RLPHitterRow(pos: .IF1B)
        }
        .frame(minHeight: 75.0)
        
    }
}

enum HitterRowState: String {
    case inline, expanded
}

// MARK: - custom view modifiers
