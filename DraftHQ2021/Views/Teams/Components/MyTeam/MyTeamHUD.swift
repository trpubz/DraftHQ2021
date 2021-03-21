//
//  MyTeamHUD.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/4/20.
//  Copyright © 2020 trpubz. All rights reserved.
//  Component sits in the upperright corner of dashboard adjacent to the League info quick display

import SwiftUI

struct MyTeamHUD: View {
    @EnvironmentObject var league: League
    var me: Team { self.league.teams[0] }
    
    var body: some View {
        HStack {
            Group {
                Text("PUBE")
                    .font(.title)
                    .fontWeight(.ultraLight)
                VStack(alignment: .trailing) {
                    Text("₪ \(league.teams[0].budget)")
                        .font(.headline)
                    Text(league.teams[0].rosterToString)
                        .frame(width: 100, alignment: .trailing)
                    Text("Max : ₪ \(league.teams[0].budgetMax)")
                    Text("Avg : ₪ \(league.teams[0].budgetAvg)")
                    Text(league.teams[0].projRecordToString)
                        .lineLimit(1)
                        .frame(width: 150, alignment: .trailing)

                }
                Divider()
                    .padding(.vertical)
            }
            
            
            VStack {
                Text("OVR")
                    .font(.headline)
                    .fontWeight(.thin)
                Text("\(league.teams[0].rnkOVR)")
                    .font(.title)
            }
            Divider()
            .padding(.vertical)
            //Hitting Ranks
            HStack {
                HStack {
                    VStack {
                        Text("HIT")
                            .font(.headline)
                            .fontWeight(.thin)
                        Text("\(league.teams[0].rnkHIT)")
                            .font(.title)
                    }
                    VStack {
                        HStack {
                            StatBox("HR")
                            RankBox(league.teams[0].rnkHR)
                        }
                        HStack {
                            StatBox("R")
                            RankBox(league.teams[0].rnkR)
                        }
                        HStack {
                            StatBox("RBI")
                            RankBox(league.teams[0].rnkRBI)
                        }
                    }
                    VStack {

                        HStack {
                            StatBox("NSB")
                            RankBox(league.teams[0].rnkNSB)
                        }
                        HStack {
                            StatBox("OBP")
                            RankBox(league.teams[0].rnkOBP)
                        }
                        HStack {
                            StatBox("SLG")
                            RankBox(league.teams[0].rnkSLG)
                        }
                    }
                }
            }.frame(width: 175)
            Divider()
            .padding(.vertical)
            //Pitching Ranks
            HStack {
                HStack {
                    VStack {
                        Text("PIT")
                            .font(.headline)
                            .fontWeight(.thin)
                        Text("\(league.teams[0].rnkPIT)")
                            .font(.title)
                    }
                    VStack {

                        HStack {
                            StatBox("IP")
                            RankBox(league.teams[0].rnkIP)
                        }
                        HStack {
                            StatBox("QS")
                            RankBox(league.teams[0].rnkQS)
                        }
                        HStack {
                            StatBox("SVH")
                            RankBox(league.teams[0].rnkSVHD)
                        }
                    }
                    VStack {
                        HStack {
                            StatBox("ERA")
                            RankBox(league.teams[0].rnkERA)
                        }
                        HStack {
                            StatBox("WIP")
                            RankBox(league.teams[0].rnkWHIP)
                        }
                        HStack {
                            StatBox("K/9")
                            RankBox(league.teams[0].rnkKp9)
                        }
                    }
                }
            }.frame(width: 175)
            
        }
        .frame(width: 685, height: 90)
    }
}

struct StatBox: View {
    var stat: String
    var body: some View {
        Text(stat)
            .frame(width: 30, alignment: .leading)
    }
    init(_ str: String) {
        self.stat = str
    }
}
struct RankBox: View {
    var rnk: Int
    var body: some View {
        Text(rnk.string)
            .lineLimit(1)
            .frame(width: 26, alignment: .trailing)
    }
    init(_ rnk: Int) {
        self.rnk = rnk
    }
}

struct MyTeamHUD_Previews: PreviewProvider {
    static var previews: some View {
        MyTeamHUD()
            .environmentObject(League())
    }
}
