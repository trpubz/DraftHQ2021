//
//  SearchResults.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 6/3/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct SearchResults: View {
    var player: Player?
    
    var body: some View {
        VStack {
            if player?.priPos == .SP || player?.priPos == .RP {
                ResultsHeaderPitcher()
                ResultsPitcher(pitcher: player as! Pitcher)
            } else {
                ResultsHeaderHitter()
                ResultsHitter(hitter: player as! Hitter)
            }
            ExpandedPlayerRow(plyr: player!, rowState: .constant(.expanded))
        }
    }
}
struct ResultsPitcher: View {
    var pitcher: Pitcher
    var body: some View {
        HStack {
            Group {
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
    }
}
struct ResultsHitter: View {
    var hitter: Hitter
    
    var body: some View {
        HStack {
            Group {
                NameCol(name: hitter.name)
                TeamCol(team: hitter.mlbTeam)
                PosCol(strPos: hitter.strPos)
                AVCol(av: "₪ \(Int(hitter.shekels))")
                StatCol(stat: "\(String(format: "%.1f", hitter.wRAA))")
            }
            Group {
                StatCol(stat: "\(hitter.HR)").foregroundColor(hitter.drafted ? .gray : .primary)
                StatCol(stat: "₪ \(Int(hitter.vHR))")
                StatCol(stat: "\(hitter.R)")
                StatCol(stat: "₪ \(Int(hitter.vR))")
                StatCol(stat: "\(hitter.RBI)")
                StatCol(stat: "₪ \(Int(hitter.vRBI))")
                StatCol(stat: "\(hitter.NSB)")
                StatCol(stat: "₪ \(Int(hitter.vNSB))")
            }
            Group {
                StatCol(stat: formattedStat(forHIT: hitter.OBP))
                StatCol(stat: "₪ \(Int(hitter.vOBP))")
                StatCol(stat: formattedStat(forHIT: hitter.SLG))
                StatCol(stat: "₪ \(Int(hitter.vSLG))")
            }
        }
    }
}
struct ResultsHeaderPitcher: View {
    var body: some View {
        HStack {
            Group {
                NameCol(name: "Name")
                TeamCol(team: "Team")
                PosCol(strPos: "Pos.")
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
        }
    }
}
struct ResultsHeaderHitter: View {
    var body: some View {
        HStack {
            Group {
                NameCol(name: "Name")
                TeamCol(team: "Team")
                PosCol(strPos: "Pos.")
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
        }
    }
}

struct SearchResults_Previews: PreviewProvider {
    static var previews: some View {
        SearchResults(player: League().allOF[0])
    }
}
