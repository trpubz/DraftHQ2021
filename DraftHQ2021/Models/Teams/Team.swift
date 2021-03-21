//
//  Team.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 4/17/20.
//  Copyright © 2020 trpubz. All rights reserved.
//  Abbreviation References:
//  APA - Average Player Available (at a given position); used to estimate the remaining talent in a player pool after a player has been drafted.

import Foundation

final class Team: Codable, Identifiable, ObservableObject {
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
    func cleanRecord() {
        self.tmW = 0
        self.tmL = 0
        self.tmT = 0
    }
    //------------------
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
    
    init(tmAbbrv: String, teamName: String, owner: String) {
        self.tmAbbrv = tmAbbrv
        self.teamName = teamName
        self.owner = owner
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
    
    //conform to Codeable Protocol
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tmAbbrv, forKey: .tmAbbrv)
        try container.encode(teamName, forKey: .teamName)
        try container.encode(owner, forKey: .owner)
    }
}

extension Team: Equatable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
}

