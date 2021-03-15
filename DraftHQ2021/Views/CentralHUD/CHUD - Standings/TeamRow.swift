//
//  TeamRow.swift
//  DraftHQ2021
//
//  Created by TP on 6/5/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct TeamRow: View {
    @ObservedObject var tm: Team
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                TeamText(tm: tm.tmAbbrv)
                ProjRecText(projRec: "\(tm.tmW)-\(tm.tmL)-\(tm.tmT)")
                StatText(stat: tm.rnkOVR.string)
            }
            HStack(spacing: 0) {
                StatText(stat: tm.rnkHIT.string)
                ForEach(tm.arrStatsHIT, id: \.self) { stat in
                    StatText(stat: stat)
                }
            }
            HStack(spacing: 0) {
                StatText(stat: tm.rnkPIT.string)
                ForEach(tm.arrStatsPIT, id: \.self) { stat in
                    StatText(stat: stat)
                }
            }
            
        }
    }
}

struct TeamText: View {
    var tm: String
    var body: some View {
        Text(tm)
            .frame(width: 44, alignment: .leading)
    }
}
struct ProjRecText: View {
    var projRec: String
    var body: some View {
        Text(projRec)
            .frame(width: 79, alignment: .trailing)
    }
}
struct StatText: View {
    var stat: String
    var body: some View {
        Text(stat)
            .frame(width: 55)
    }
}

struct TeamRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StandingsHeader(sortedColumn: .constant(.none), sortedStyle: .constant(.desc))
            TeamRow(tm: league.teams[0])
        }
    }
}
