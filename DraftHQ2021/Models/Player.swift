//
//  Player.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 4/17/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import Foundation

class Player: ObservableObject, Identifiable, Hashable {
    
    
    let id: UUID = UUID()
    let playerid: String
    let name: String
    let mlbTeam: String
    @Published var draftedTeam: Team?
    let strPos: String
    var priPos: POS? = nil
//    var shekels: Double = 1.0
    @Published var drafted: Bool = false
    
    init(playerid: String, name: String, mlbTeam: String, strPos: String, priPos: POS) {
        self.playerid = playerid
        self.name = name
        self.mlbTeam = mlbTeam
        self.strPos = strPos
        self.priPos = priPos
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

final class Hitter: Player, Decodable {
    //u-prefix stands for useful stats aka value above replacement: stat - rlp.stat
    //v-prefix stands for useful weighted value of a stat: (stat - rlp.stat) / league.stat * stat budget
    var rlp: RLPHitter!
    let PA: Int
    let AB: Int
    let wRAA: Double
    let wOBA: Double
    var shekels: Double { vHR + vR + vRBI + vNSB + vOBP + vSLG }
    let HR: Int
    var uHR: Int { HR - rlp.HR }
    var vHR: Double = 0
    let R: Int
    var uR: Int { R - rlp.R }
    var vR: Double = 0
    let RBI: Int
    var uRBI: Int { RBI - rlp.RBI }
    var vRBI: Double = 0
    let NSB: Int
    var uNSB: Int { NSB - rlp.NSB }
    var vNSB: Double = 0
    let OBP: Double
    let wOBP: Double
    var uOBP: Double { wOBP - rlp.wOBP }
    var vOBP: Double = 0
    let SLG: Double
    let wSLG: Double
    var uSLG: Double { wSLG - rlp.wSLG }
    var vSLG: Double = 0

    
    func setUsefulWeightedValue(with pp: [POS:PlayerPoolHitter]) {
        self.vHR = bHR * Double(uHR) / pp.values.map({Double($0.uHR)}).total
        self.vR = bR * Double(uR) / pp.values.map({Double($0.uR)}).total
        self.vRBI = bRBI * Double(uRBI) / pp.values.map({Double($0.uRBI)}).total
        self.vNSB = bNSB * Double(uNSB) / pp.values.map({Double($0.uNSB)}).total
        self.vOBP = bOBP * uOBP / pp.values.map({$0.uOBP}).total
        self.vSLG = bSLG * uSLG / pp.values.map({$0.uSLG}).total
    }
    
    func printStatLine() {
        let frmt: String = "%-25@s | HR:%2d | R:%3d | RBI:%3d | NSB:%2d | wOBP:%3.1f | wSLG%3.1f"
        print(String(format: frmt, name, HR, R, RBI, NSB, wOBP, wSLG))
    }
    init(nm: String, mlbTm: String, strPos: String, priPos: POS, pID: String, PA: Int, AB: Int, wRAA: Double, wOBA: Double, HR: Int, R: Int, RBI: Int, NSB: Int, OBP: Double, SLG: Double) {
        self.PA = PA
        self.AB = AB
        self.wRAA = wRAA
        self.wOBA = wOBA
        self.HR = HR
        self.R = R
        self.RBI = RBI
        self.NSB = NSB
        self.OBP = OBP
        self.SLG = SLG
        
        let lastYrOBP: Double = 0.343
        let lastYrSLG: Double = 0.469
        self.wSLG = (SLG - lastYrSLG) * Double(AB)
        self.wOBP = (OBP - lastYrOBP) * Double(PA)
        
        super.init(playerid: pID, name: nm, mlbTeam: mlbTm, strPos: strPos, priPos: priPos)
    }
}
// MARK: - decoding logic for Hitter Class
extension Hitter {
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case mlbTeam = "Team"
        case strPos = "Pos."
        case playerid
        case wRAA, wOBA
        case PA, AB
        case HR, R, RBI, NSB, OBP, SLG
    }
    
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try values.decode(String.self, forKey: .name)
        let mlbTeam = try values.decode(String.self, forKey: .mlbTeam)
        let strPos = try values.decode(String.self, forKey: .strPos)
        let playerid = try values.decode(String.self, forKey: .playerid)
        let wRAA = try values.decode(Double.self, forKey: .wRAA)
        let wOBA = try values.decode(Double.self, forKey: .wOBA)
        let PA = try values.decode(Int.self, forKey: .PA)
        let AB = try values.decode(Int.self, forKey: .AB)
        let HR = try values.decode(Int.self, forKey: .HR)
        let R = try values.decode(Int.self, forKey: .R)
        let RBI = try values.decode(Int.self, forKey: .RBI)
        let NSB = try values.decode(Int.self, forKey: .NSB)
        let OBP = try values.decode(Double.self, forKey: .OBP)
        let SLG = try values.decode(Double.self, forKey: .SLG)
        
        self.init(nm: name, mlbTm: mlbTeam, strPos: strPos, priPos: .LBN, pID: playerid,
                  PA: PA, AB: AB, wRAA: wRAA, wOBA: wOBA, HR: HR, R: R, RBI: RBI, NSB: NSB, OBP: OBP, SLG: SLG)
    }
}

final class Pitcher: Player, Decodable {
    var rlp: RLPPitcher!
    var shekels: Double { vIP + vQS + vSVHD + vERA + vWHIP + vKp9 }
    let wFIP: Double
    let FIP: Double
    let IP: Int
    var uIP: Int { IP - rlp.IP }
    var vIP: Double = 0.0
    let QS: Int
    var uQS: Int {
        if self.priPos == .SP {
            return QS - rlp.QS
        } else { return 0 }
    }
    var vQS: Double = 0.0
    let SVHD: Int
    var uSVHD: Int {
        if self.priPos == .RP {
            return SVHD - rlp.SVHD
        } else { return 0 }
    }
    var vSVHD: Double = 0.0
    let ERA: Double
    let wERA: Double
    var uERA: Double { wERA - rlp.wERA}
    var vERA: Double = 0.0
    let WHIP: Double
    let wWHIP: Double
    var uWHIP: Double { wWHIP - rlp.wWHIP }
    var vWHIP: Double = 0.0
    let Kp9: Double
    let wKp9: Double
    var uKp9: Double { wKp9 - rlp.wKp9 }
    var vKp9: Double = 0.0

    
    func setUsefulWeightedValue(with pp: [POS:PlayerPoolPitcher]) {
        self.vIP = bIP * Double(uIP) / pp.values.map({Double($0.uIP)}).total
        self.vQS = bQS * Double(uQS) / pp.values.map({Double($0.uQS)}).total
        self.vSVHD = bSVHD * Double(uSVHD) / pp.values.map({Double($0.uSVHD)}).total
        self.vERA = bERA * Double(uERA) / pp.values.map({Double($0.uERA)}).total
        self.vWHIP = bWHIP * uWHIP / pp.values.map({$0.uWHIP}).total
        self.vKp9 = bKp9 * uKp9 / pp.values.map({$0.uKp9}).total
    }
    
    func printStatLine() {
        let frmt: String = "%-.25@ | IP:%3d | QS:%2d | SVHD:%2d | wERA:%3.1f | wWHIP:%3.1f | wKp9:%3.1f"
        print(String(format: frmt, name, IP, QS, SVHD, wERA, wWHIP, wKp9))
    }
    
    init(nm: String, mlbTm: String, strPos: String, pID: String, priPos: POS, wFIP: Double, FIP: Double, IP: Int, QS: Int, SVHD: Int, ERA: Double, WHIP: Double, Kp9: Double) {
        self.wFIP = wFIP
        self.FIP = FIP
        self.IP = IP
        self.QS = QS
        self.SVHD = SVHD
        self.ERA = ERA
        self.WHIP = WHIP
        self.Kp9 = Kp9
        
        //convert rate stats to counting
        //these numbers are pulled from the league itself
        let lastYrAvgERA: Double = 3.82
        let lastYrAvgWHIP: Double = 1.22
        let lastYrAvgKp9: Double = 9.68
        self.wERA = (lastYrAvgERA - ERA) * Double(IP)
        self.wWHIP = (lastYrAvgWHIP - WHIP) * Double(IP)
        self.wKp9 = (Kp9 - lastYrAvgKp9) * Double(IP)
        
        super.init(playerid: pID, name: nm, mlbTeam: mlbTm, strPos: strPos, priPos: priPos)
    }
}
// MARK: - decoding logic for Pitcher Class
extension Pitcher {
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case mlbTeam = "Team"
        case strPos = "Pos."
        case playerid
        case wFIP, FIP
        case IP, QS, SVHD, ERA, WHIP
        case Kp9 = "K/9"
    }
    
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try values.decode(String.self, forKey: .name)
        let mlbTeam = try values.decode(String.self, forKey: .mlbTeam)
        let strPos = try values.decode(String.self, forKey: .strPos)
        let playerid = try values.decode(String.self, forKey: .playerid)
        let wFIP = try values.decode(Double.self, forKey: .wFIP)
        let FIP = try values.decode(Double.self, forKey: .FIP)
        let IP = try values.decode(Int.self, forKey: .IP)
        let QS = try values.decode(Int.self, forKey: .QS)
        let SVHD = try values.decode(Int.self, forKey: .SVHD)
        let ERA = try values.decode(Double.self, forKey: .ERA)
        let WHIP = try values.decode(Double.self, forKey: .WHIP)
        let Kp9 = try values.decode(Double.self, forKey: .Kp9)
        
        self.init(nm: name, mlbTm: mlbTeam, strPos: strPos, pID: playerid, priPos: .LBN,
                  wFIP: wFIP, FIP: FIP, IP: IP, QS: QS, SVHD: SVHD, ERA: ERA, WHIP: WHIP, Kp9: Kp9)
    }
}
// MARK: - Replacement Level Player models
class RLP {
    let pos: POS
    
    init(pos: POS) {
        self.pos = pos
    }
}
class RLPHitter: RLP {
    let wRAA: Double
    let HR: Int
    let R: Int
    let RBI: Int
    let NSB: Int = 1
    let OBP: Double
    let wOBP: Double
    let SLG: Double
    let wSLG: Double
    
    init(pos: POS, withHitters bats: [Hitter]) {
        self.wRAA = bats.map({$0.wRAA}).average
        self.HR = Int(bats.map({$0.HR}).average)
        self.R = Int(bats.map({$0.R}).average)
        self.RBI = Int(bats.map({$0.RBI}).average)
        //don't bother importing NSB because of my value assumptions
        self.OBP = bats.map({$0.OBP}).average
        self.wOBP = bats.map({$0.wOBP}).average
        self.SLG = bats.map({$0.SLG}).average
        self.wSLG = bats.map({$0.wSLG}).average
        super.init(pos: pos)
        //print("RL Players for \(pos):")
        //bats.forEach({$0.printStatLine()})
    }
}
class RLPPitcher: RLP {
    let wFIP: Double
    let IP: Int
    let QS: Int
    let SVHD: Int = 21
    let ERA: Double
    let wERA: Double
    let WHIP: Double
    let wWHIP: Double
    let Kp9: Double
    let wKp9: Double
    
    init(pos: POS, withPitchers arms: [Pitcher]) {
        self.wFIP = arms.map({$0.wFIP}).average
        if pos == .RP {
            self.IP = 60
        } else {
            self.IP = Int(arms.map({$0.IP}).average)
        }
        self.QS = Int(arms.map({$0.QS}).average)
        //self.SVHD = Int(arms.map({$0.SVHD}).average)
        self.ERA = arms.map({$0.ERA}).average
        self.wERA = arms.map({$0.wERA}).average
        self.WHIP = arms.map({$0.WHIP}).average
        self.wWHIP = arms.map({$0.wWHIP}).average
        self.Kp9 = arms.map({$0.Kp9}).average
        self.wKp9 = arms.map({$0.wKp9}).average
        super.init(pos: pos)
        //print("RL Players for \(pos):")
        //arms.forEach({$0.printStatLine()})
    }
}

// MARK: - Global Functions
func formattedStat(forHIT: Double) -> String {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 3
    formatter.maximumIntegerDigits = 0
    return formatter.string(from: NSNumber(value: forHIT))!
}

func formattedStat(forPIT: Double) -> String {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 2
    formatter.maximumIntegerDigits = 2
    return formatter.string(from: NSNumber(value: forPIT))!
}

enum POS: String {
    case C, SS, OF, DH
    case IF1B = "1B"
    case IF2B = "2B"
    case IF3B = "3B"
    case SP, RP
    case LBN
}
