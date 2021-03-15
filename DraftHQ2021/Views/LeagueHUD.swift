//
//  LeagueHUD.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/4/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct LeagueHUD: View {
    @ObservedObject var lg: League = league
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text("The Great 'Merican Fantasy Invitational")
                    .font(.subheadline)
                    .fontWeight(.ultraLight)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Text("Total budget remaining: ")
                        .frame(width: 150, alignment: .leading)
                    Text("₪ \(lg.leagueShekels)")
                        .fontWeight(.semibold)
                        .frame(width: 70, alignment: .trailing)
                }
                HStack {
                    Text("Total value remaining: ")
                        .frame(width: 150, alignment: .leading)
                    Text("₪ \(lg.valueOfUndrafted)")
                        .fontWeight(.semibold)
                        .frame(width: 70, alignment: .trailing)
                }
                HStack {
                    Text("Total players drafted: ")
                        .frame(width: 150, alignment: .leading)
                    Text("\(lg.playersDrafted) / 252")
                        .fontWeight(.semibold)
                        .frame(width: 70, alignment: .trailing)
                }
            }
            Spacer()
            Divider()
                .padding(.vertical)
            Spacer()
            //Right Side Leaderboard
            VStack {
                Spacer()
                Text("Leaders")
                    .font(.headline)
                    .underline()

                //LEADERBOARD
                HStack {
                    VStack {
                        StatGrouping(stat: "HR", group: lg.rnksHR)
                        StatGrouping(stat: "R", group: lg.rnksR)
                        StatGrouping(stat: "RBI", group: league.rnksRBI)
                    }
                    Divider()
                    VStack {
                        StatGrouping(stat: "NSB", group: league.rnksNSB)
                        StatGrouping(stat: "wSLG", group: league.rnksOBP)
                        StatGrouping(stat: "wOBP", group: league.rnksSLG)
                    }
                    Divider()
                    VStack {
                        StatGrouping(stat: "IP", group: league.rnksIP)
                        StatGrouping(stat: "QS", group: league.rnksQS)
                        StatGrouping(stat: "SVHD", group: league.rnksSVHD)
                    }
                    Divider()
                    VStack {
                        StatGrouping(stat: "wERA", group: league.rnksERA)
                        StatGrouping(stat: "wWHIP", group: league.rnksWHIP)
                        StatGrouping(stat: "wK/9", group: league.rnksKp9)
                    }
                    
                }
                Spacer()
            }
            
        }
        .frame(width: 675, height: 90)
    }
}

struct StatGrouping: View {
    var stat: String
    var group: [String:Int]
    private var leader: String {group.sorted(by: {$0.value < $1.value}).first!.key}
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 3) {
            Text(stat)
                .fontWeight(.regular)
                .frame(width: 44, alignment: .leading)
            Text(leader)
                .fontWeight(.bold)
                .frame(width: 40, alignment: .trailing)
        }
    }
}

struct LeagueHUD_Previews: PreviewProvider {
    static var previews: some View {
        LeagueHUD()
    }
}
