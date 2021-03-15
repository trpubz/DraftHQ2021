//
//  StandingsView.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 6/3/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct StandingsView: View {
    @State private var sortedColumn: SortColumn = .none
    @State private var sortedStyle: SortStyle = .none
    private var teams: [Team] {
        print("sorting by \(sortedColumn.rawValue) \(sortedStyle.rawValue)")
        switch sortedColumn {
        case .OVR:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.OVR < $1.OVR} : {$0.OVR > $1.OVR})
        case .HIT:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.HIT < $1.HIT} : {$0.HIT > $1.HIT})
        case .HR:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totHR > $1.totHR} : {$0.totHR < $1.totHR})
        case .R:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totR > $1.totR} : {$0.totR < $1.totR})
        case .RBI:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totRBI > $1.totRBI} : {$0.totRBI < $1.totRBI})
        case .NSB:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totNSB > $1.totNSB} : {$0.totNSB < $1.totNSB})
        case .OBP:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totOBP > $1.totOBP} : {$0.totOBP < $1.totOBP})
        case .SLG:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totSLG > $1.totSLG} : {$0.totSLG < $1.totSLG})
        case .PIT:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.PIT < $1.PIT} : {$0.PIT > $1.PIT})
        case .QS:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totQS > $1.totQS} : {$0.totQS < $1.totQS})
        case .IP:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totIP > $1.totIP} : {$0.totIP < $1.totIP})
        case .SVHD:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totSVHD > $1.totSVHD} : {$0.totSVHD < $1.totSVHD})
        case .ERA:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totERA > $1.totERA} : {$0.totERA < $1.totERA})
        case .WHIP:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totWHIP > $1.totWHIP} : {$0.totWHIP < $1.totWHIP})
        case .Kp9:
            return league.teams.sorted(by: sortedStyle == .desc ? {$0.totKp9 > $1.totKp9} : {$0.totKp9 < $1.totKp9})
        default:
            return league.teams
        }
    }
    
    var body: some View {
        VStack {
            List {
                StandingsHeader(sortedColumn: $sortedColumn, sortedStyle: $sortedStyle)
                Divider()
                ForEach(teams) { tm in
                    TeamRow(tm: tm)
                }
            }.frame(height: 375)
        }
    }
}

enum SortColumn: String {
    case REC, OVR, HIT, PIT, none
    case HR, R, RBI, NSB, OBP, SLG
    case IP, QS, SVHD, ERA, WHIP
    case Kp9 = "K/9"
}

enum SortStyle: String {
    case asc, desc, none
}


struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView()
            .frame(width: 965, height: 375)
    }
}
