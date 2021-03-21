//
//  HeaderRows.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/4/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct HitterHeaderRow: View {
    var body: some View {
        HStack {
            Group {
                Text("Draft")
                    .frame(width: 33.0)
                NameCol(name: "Name")
                TeamCol(team: "Team")
                PosCol(strPos: "POS.")
                AVCol(av: "₪AV₪")
                StatCol(stat: "wRAA")
            }
            Group {
                StatCol(stat: "HR")
                StatCol(stat: "₪HR")
                StatCol(stat: "R")
                StatCol(stat: "₪R")
                StatCol(stat: "RBI")
                StatCol(stat: "₪RBI")
                StatCol(stat: "NSB")
                StatCol(stat: "₪NSB")
            }
            Group {
                StatCol(stat: "OBP")
                StatCol(stat: "₪OBP")
                StatCol(stat: "SLG")
                StatCol(stat: "₪SLG")
            }
        }//.frame(width: 950)
    }
}

struct PitcherHeaderRow: View {
    var body: some View {
        HStack {
            Group {
                Text("Draft")
                    .frame(width: 33.0)
                NameCol(name: "Name")
                TeamCol(team: "Team")
                PosCol(strPos: "POS.")
                AVCol(av: "₪AV₪")
                StatCol(stat: "wFIP")
            }
            Group {
                StatCol(stat: "IP")
                StatCol(stat: "₪IP")
                StatCol(stat: "QS")
                StatCol(stat: "₪QS")
                StatCol(stat: "SVHD")
                StatCol(stat: "₪SH")
                StatCol(stat: "ERA")
                StatCol(stat: "₪ERA")
            }
            Group {
                StatCol(stat: "WHIP")
                StatCol(stat: "₪WHP")
                StatCol(stat: "Kp9")
                StatCol(stat: "₪Kp9")
            }
        }//.frame(width: 950)
    }
    
}

struct NameCol: View {
    var name: String
    var body: some View {
        Text(name)
            
            .lineLimit(1)
            .frame(width: 90.0, alignment: .leading)
    }
}
struct TeamCol: View {
    var team: String
    var body: some View {
        Text(team)
            .frame(width: 35.0, alignment: .leading)
    }
}
struct PosCol: View {
    var strPos: String
    var body: some View {
        Text(strPos)
            .lineLimit(1)
            .frame(width: 57.0, alignment: .leading)
    }
}
struct AVCol: View {
    var av: String
    var body: some View {
        Text(av)
            .fontWeight(.semibold)
            .frame(width: 42.0, alignment: .trailing)
    }
}
struct StatCol: View {
    var stat: String
    var rawNum: Int {
        Int(stat.components(separatedBy: "₪ ").last ?? "1") ?? 1
    }
    var body: some View {
        Text(stat)
            .foregroundColor(rawNum < 0 ? Color.red : Color.primary)
            .frame(width: 42.0, alignment: .trailing)
    }
}

struct HeaderRows_Previews: PreviewProvider {
    static var previews: some View {
//        List {
//            HitterHeaderRow()
//            HitterRow(hitter: league.hitters.first(where: {$0.name == "Jeff McNeil"})!)
//        }.frame(width: 1000)
        List {
            PitcherHeaderRow()
            PitcherRow(pitcher: League().pitchers.first(where: {$0.name == "Gerrit Cole"})!)
        }.frame(width: 1000)
    }
}
