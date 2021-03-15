//
//  Team.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 4/17/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import Foundation

final class Team: Decodable, Identifiable, ObservableObject {
    let id = UUID()
    let tmAbbrv: String
    let teamName: String
    let owner: String
    @Published var budget: Int = 260
    var budgetMax: Int { budget - 21 + drafted }
    var budgetAvg: Int { budget / (21 - drafted) }
    @Published var roster: [RosterSlot: Player] = [:]
    var sticks: [Hitter] {
        var temp = [Hitter]()
        for plyr in roster.values {
            switch plyr.priPos {
            case .C, .IF1B, .IF2B, .IF3B, .SS, .OF, .DH:
                temp.append(plyr as! Hitter)
            default:
                continue //onto the next
            }
        }
        return temp
    }
    var arms: [Pitcher] {
        var temp = [Pitcher]()
        for plyr in roster.values {
            switch plyr.priPos {
            case .SP, .RP:
                temp.append(plyr as! Pitcher)
            default:
                continue //onto the next
            }
        }
        return temp
    }
    var drafted: Int {
        var actualPlayers: Int = 0
        for plyr in roster.values {
            if !plyr.name.hasPrefix("apa") {
                actualPlayers += 1
            }
        }
        return actualPlayers
    }
    var rosterToString: String { "Roster: \(drafted) / 21" }
    
    var OVR: Int { HIT + PIT }
    @Published var rnkOVR: Int = 0
    //------------------
    var HIT: Int { rnkHR + rnkR + rnkRBI + rnkNSB + rnkOBP + rnkSLG }
    var arrStatsHIT: [String] { [totHR.string, totR.string, totRBI.string, totNSB.string, totOBP.string, totSLG.string] }
    @Published var rnkHIT: Int = 0
    var totHR: Int { sticks.map({$0.HR}).total }
    @Published var rnkHR: Int = 0
    var totR: Int { sticks.map({$0.R}).total }
    @Published var rnkR: Int =  0
    var totRBI: Int { sticks.map({$0.RBI}).total }
    @Published var rnkRBI: Int = 0
    var totNSB: Int { sticks.map({$0.NSB}).total }
    @Published var rnkNSB: Int = 0
    var totOBP: Int { sticks.map({Int($0.wOBP)}).total }
    @Published var rnkOBP: Int = 0
    var totSLG: Int { sticks.map({Int($0.wSLG)}).total }
    @Published var rnkSLG: Int = 0
    //------------------
    var PIT: Int { rnkIP + rnkQS + rnkSVHD + rnkERA + rnkWHIP + rnkKp9 }
    var arrStatsPIT: [String] { [totIP.string, totQS.string, totSVHD.string, totERA.string, totWHIP.string, totKp9.string] }
    @Published var rnkPIT: Int = 0
    var totIP: Int { arms.map({$0.IP}).total }
    @Published var rnkIP: Int = 0
    var totQS: Int { arms.map({$0.QS}).total }
    @Published var rnkQS: Int =  0
    var totSVHD: Int { arms.map({$0.SVHD}).total }
    @Published var rnkSVHD: Int = 0
    var totERA: Int { arms.map({Int($0.wERA)}).total }
    @Published var rnkERA: Int = 0
    var totWHIP: Int { arms.map({Int($0.wWHIP)}).total }
    @Published var rnkWHIP: Int = 0
    var totKp9: Int { arms.map({Int($0.wKp9)}).total }
    @Published var rnkKp9: Int = 0
    //------------------
    @Published var tmW: Int = 0
    @Published var tmL: Int = 0
    @Published var tmT: Int = 0
    var projRecordToString: String { "Proj. Record: \(tmW)-\(tmL)-\(tmT)" }
    
    func instantiateRoster(withLeague lg: League) {
        self.roster[.C] = lg.ppC.apa
        self.roster[.IF1B] = lg.pp1B.apa
        self.roster[.IF2B] = lg.pp2B.apa
        self.roster[.IF3B] = lg.pp3B.apa
        self.roster[.SS] = lg.ppSS.apa
        self.roster[.OF1] = lg.ppOF.apa
        self.roster[.OF2] = lg.ppOF.apa
        self.roster[.OF3] = lg.ppOF.apa
        self.roster[.DH] = lg.ppDH.apa
        //bench slots, 3 for offense, 2 for pitching
        self.roster[.BN1] = lg.ppOF.apa
        self.roster[.BN2] = lg.ppOF.apa
        self.roster[.BN3] = lg.ppOF.apa
        self.roster[.BN4] = lg.ppSP.apa
        self.roster[.BN5] = lg.ppSP.apa
        //pitching
        self.roster[.SP1] = lg.ppSP.apa
        self.roster[.SP2] = lg.ppSP.apa
        self.roster[.SP3] = lg.ppSP.apa
        self.roster[.SP4] = lg.ppSP.apa
        self.roster[.P1] = lg.ppSP.apa
        self.roster[.RP1] = lg.ppRP.apa
        self.roster[.RP2] = lg.ppRP.apa
//        let fmt = "%4@  %@\n"
//        print(
//            tmAbbrv + "\n" +
//            String(format: fmt, "ROS ", "NAME") +
//            String(format: fmt, "C   ", roster[.C]!.name) +
//            String(format: fmt, "1B  ", roster[.IF1B]!.name) +
//            String(format: fmt, "2B  ", roster[.IF2B]!.name) +
//            String(format: fmt, "3B  ", roster[.IF3B]!.name) +
//            String(format: fmt, "SS  ", roster[.SS]!.name) +
//            String(format: fmt, "OF1 ", roster[.OF1]!.name) +
//            String(format: fmt, "OF2 ", roster[.OF2]!.name) +
//            String(format: fmt, "OF3 ", roster[.OF3]!.name) +
//            String(format: fmt, "DH  ", roster[.DH]!.name) +
//            String(format: fmt, "SP1 ", roster[.SP1]!.name) +
//            String(format: fmt, "SP2 ", roster[.SP2]!.name) +
//            String(format: fmt, "SP3 ", roster[.SP3]!.name) +
//            String(format: fmt, "SP4 ", roster[.SP4]!.name) +
//            String(format: fmt, "P1  ", roster[.P1]!.name) +
//            String(format: fmt, "RP1 ", roster[.RP1]!.name) +
//            String(format: fmt, "RP1 ", roster[.RP2]!.name)
//        )
    }
    
    func resetRecord() {
        self.tmW = 0
        self.tmL = 0
        self.tmT = 0
    }
    init(tmAbbrv: String, teamName: String, owner: String) {
        self.tmAbbrv = tmAbbrv
        self.teamName = teamName
        self.owner = owner
    }
}
// MARK: - draft logic
extension Team {
    func draft(player: Player, forShek: Int) {
        logEvent("Team.swift/class Team/func draft -> \(self.tmAbbrv) drafted \(player.name) for: ₪\(forShek)")
        self.budget -= forShek
        player.draftedTeam = self
        func assignToDHorBN() {
            if roster[.DH]!.name.hasPrefix("apa") {
                roster[.DH] = player
            } else { assignToBN() }
        }
        func assignToPorBN() {
            if roster[.P1]!.name.hasPrefix("apa") {
                roster[.P1] = player
            } else { assignToBN() }
        }
        func assignToBN() {
            if roster[.BN1]!.name.hasPrefix("apa") {
                roster[.BN1] = player
            } else if roster[.BN2]!.name.hasPrefix("apa") {
                roster[.BN2] = player
            } else if roster[.BN3]!.name.hasPrefix("apa") {
                roster[.BN3] = player
            } else if roster[.BN4]!.name.hasPrefix("apa") {
                roster[.BN4] = player
            } else if roster[.BN5]!.name.hasPrefix("apa") {
                roster[.BN5] = player
            }
        }
        
        switch player.priPos {
        case .OF:
            if roster[.OF1]!.name.hasPrefix("apa") {
                roster[.OF1] = player
            } else if roster[.OF2]!.name.hasPrefix("apa") {
                roster[.OF2] = player
            } else if roster[.OF3]!.name.hasPrefix("apa") {
                roster[.OF3] = player
            } else { assignToDHorBN() }
        case .DH:
            assignToDHorBN()
        case .SP:
            if roster[.SP1]!.name.hasPrefix("apa") {
                roster[.SP1] = player
            } else if roster[.SP2]!.name.hasPrefix("apa") {
                roster[.SP2] = player
            } else if roster[.SP3]!.name.hasPrefix("apa") {
                roster[.SP3] = player
            } else if roster[.SP4]!.name.hasPrefix("apa") {
                roster[.SP4] = player
            } else { assignToPorBN() }
        case .RP:
            if roster[.RP1]!.name.hasPrefix("apa") {
                roster[.RP1] = player
            } else if roster[.RP2]!.name.hasPrefix("apa") {
                roster[.RP2] = player
            } else { assignToPorBN() }
        default:
            if roster[RosterSlot(rawValue: player.priPos!.rawValue)!]!.name.hasPrefix("apa") {
                roster[RosterSlot(rawValue: player.priPos!.rawValue)!] = player
            } else { assignToDHorBN() }
        }
    }
    
    func updateAPA(ppHIT: PlayerPoolHitter) {
        let pos = ppHIT.pos
        
        switch pos {
        case .C, .IF1B, .IF2B, .IF3B, .SS, .DH:
            //POS enums and RosterSlot enums have the same raw value for these positions
            //use raw values to convert back and forth
            if roster[Team.RosterSlot(rawValue: pos.rawValue)!]!.name.hasPrefix("apa") {
                roster[Team.RosterSlot(rawValue: pos.rawValue)!] = ppHIT.apa
            }
        case .OF:
            if roster[.OF1]!.name.hasPrefix("apa") {
                roster[.OF1] = ppHIT.apa
            }
            if roster[.OF2]!.name.hasPrefix("apa") {
                roster[.OF2] = ppHIT.apa
            }
            if roster[.OF3]!.name.hasPrefix("apa") {
                roster[.OF3] = ppHIT.apa
            }
            //bench players use the average outfielder APA
            //bench slots for offense are assigned to the 1st 3 bench slots
            if roster[.BN1]!.name.hasPrefix("apa") {
                roster[.BN1] = ppHIT.apa
            }
            if roster[.BN2]!.name.hasPrefix("apa") {
                roster[.BN2] = ppHIT.apa
            }
            if roster[.BN3]!.name.hasPrefix("apa") {
                roster[.BN3] = ppHIT.apa
            }
        default: print("probs won't print")
        }
    }
    func updateAPA(ppPIT: PlayerPoolPitcher) {
        let pos = ppPIT.pos
        
        switch pos {
        case .SP:
            if roster[.SP1]!.name.hasPrefix("apa") {
                roster[.SP1] = ppPIT.apa
            }
            if roster[.SP2]!.name.hasPrefix("apa") {
                roster[.SP2] = ppPIT.apa
            }
            if roster[.SP3]!.name.hasPrefix("apa") {
                roster[.SP3] = ppPIT.apa
            }
            if roster[.SP4]!.name.hasPrefix("apa") {
                roster[.SP4] = ppPIT.apa
            }
            if roster[.P1]!.name.hasPrefix("apa") {
                roster[.P1] = ppPIT.apa
            }
            //bench players use the average SP APA
            //bench slots for pitching are assigned to the last 2 bench slots
            if roster[.BN4]!.name.hasPrefix("apa") {
                roster[.BN4] = ppPIT.apa
            }
            if roster[.BN5]!.name.hasPrefix("apa") {
                roster[.BN5] = ppPIT.apa
            }
        case .RP:
            if roster[.RP1]!.name.hasPrefix("apa") {
                roster[.RP1] = ppPIT.apa
            }
            if roster[.RP2]!.name.hasPrefix("apa") {
                roster[.RP2] = ppPIT.apa
            }
        default: print("probs won't print")
        }
        
    }
    enum RosterSlot: String {
        case C, SS, DH
        case IF1B = "1B"
        case IF2B = "2B"
        case IF3B = "3B"
        case OF1, OF2, OF3
        case BN1, BN2, BN3, BN4, BN5
        case SP1, SP2, SP3, SP4
        case P1
        case RP1, RP2
    }
}
// MARK: - decoding logic
extension Team {
    enum CodingKeys: String, CodingKey {
        case tmAbbrv
        case teamName
        case owner
    }
    
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let tmAbbrv = try values.decode(String.self, forKey: .tmAbbrv)
        let teamName = try values.decode(String.self, forKey: .teamName)
        let owner = try values.decode(String.self, forKey: .owner)
        
        self.init(tmAbbrv: tmAbbrv, teamName: teamName, owner: owner)
    }
}

extension Team: Equatable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
