//
//  MyRosterView.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/14/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct MyRosterView: View {
    @ObservedObject var me: Team = league.teams[0]
    
    var body: some View {
        VStack {
            Text("My Roster")
                .font(.title)
//            HStack {
//                Text("POS")
//                    .bold()
//                    .padding(0.0)
//                    .rosterPanelWidth(forColumn: .Pos)
//                Text("NAME")
//                    .bold()
//                    .padding(0.0)
//                    .rosterPanelWidth(forColumn: .Name)
//            }.frame(width: 175.0) //headers
            Group {
                Text("---STICKS---")
                    .font(.headline)
                RostersTabPlayerRow(rosterSlot: me.roster.first(where: {$0.key == .C}))
                PlayerRow(rosterSlot: .IF1B, plyr: me.roster[.IF1B]!)
                PlayerRow(rosterSlot: .IF2B, plyr: me.roster[.IF2B]!)
                PlayerRow(rosterSlot: .IF3B, plyr: me.roster[.IF3B]!)
                PlayerRow(rosterSlot: .SS, plyr: me.roster[.SS]!)
                PlayerRow(rosterSlot: .OF1, plyr: me.roster[.OF1]!)
                PlayerRow(rosterSlot: .OF2, plyr: me.roster[.OF2]!)
                PlayerRow(rosterSlot: .OF3, plyr: me.roster[.OF3]!)
                PlayerRow(rosterSlot: .DH, plyr: me.roster[.DH]!)
            }
            Group {
                Text("---ARMS---")
                .font(.headline)
                PlayerRow(rosterSlot: .SP1, plyr: me.roster[.SP1]!)
                PlayerRow(rosterSlot: .SP2, plyr: me.roster[.SP2]!)
                PlayerRow(rosterSlot: .SP3, plyr: me.roster[.SP3]!)
                PlayerRow(rosterSlot: .SP4, plyr: me.roster[.SP4]!)
                PlayerRow(rosterSlot: .P1, plyr: me.roster[.P1]!)
                PlayerRow(rosterSlot: .RP1, plyr: me.roster[.RP1]!)
                PlayerRow(rosterSlot: .RP2, plyr: me.roster[.RP2]!)
            }
            Group {
                Text("---BENCH---")
                    .font(.headline)
                PlayerRow(rosterSlot: .BN1, plyr: me.roster[.BN1]!)
                PlayerRow(rosterSlot: .BN2, plyr: me.roster[.BN2]!)
                PlayerRow(rosterSlot: .BN3, plyr: me.roster[.BN3]!)
                PlayerRow(rosterSlot: .BN4, plyr: me.roster[.BN4]!)
                PlayerRow(rosterSlot: .BN5, plyr: me.roster[.BN5]!)
            }
            Group {
                Text("---Totals---")
                    .font(.headline)
                HStack {
                    Text("HR: \(me.totHR)")
                    Text("R: \(me.totR)")
                    
                }
                HStack {
                    Text("RBI: \(me.totRBI)")
                    Text("NSB: \(me.totNSB)")
                }
                HStack {
                    Text("OBP: \(me.totOBP)")
                    Text("SLG: \(me.totSLG)")
                }
                HStack {
                    Text("IP: \(me.totIP)")
                    Text("QS: \(me.totQS)")
                }
                HStack {
                    Text("SVHD: \(me.totSVHD)")
                    Text("ERA: \(me.totERA)")
                }
                HStack {
                    Text("WHIP: \(me.totWHIP)")
                    Text("K/9: \(me.totKp9)")
                }
            }
        }
        .frame(width: 175.0)
    }
}

struct PlayerRow: View {
    var rosterSlot: Team.RosterSlot
    var plyr : Player
    var apa: Bool {
        if plyr.name.starts(with: "apa") {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        HStack {
            Text(rosterSlot.rawValue)
                .padding(0.0)
                .rosterPanelWidth(forColumn: .Pos)
            Text(plyr.name)
                .lineLimit(1)
                .padding(0.0)
                .foregroundColor(apa ? .secondary : .primary)
                .rosterPanelWidth(forColumn: .Name)
        }
        .frame(width: 175.0)
    }
}

// MARK: - My Roster View Modifiers
struct HUDRosterModifier: ViewModifier {
    var forColumn: Column
    
    func body(content: Content) -> some View {
        content
            .frame(width: forColumn == .Pos ? 50.0 : 110.0, alignment: .leading)
    }
    
    enum Column {
        case Pos, Name
    }
}

extension View {
    func rosterPanelWidth(forColumn: HUDRosterModifier.Column) -> ModifiedContent<Self, HUDRosterModifier> {
        return modifier(HUDRosterModifier(forColumn: forColumn))
    }
}


struct MyRosterView_Previews: PreviewProvider {
    static var previews: some View {
        MyRosterView()
    }
}
