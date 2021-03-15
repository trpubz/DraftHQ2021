//
//  PlayerPool.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/13/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import Foundation

struct PlayerPoolHitter {
    var players: [Hitter] = []
    let pos: POS
    var uHR: Int { players.map({$0.uHR}).total }
    var uR: Int { players.map({$0.uR}).total }
    var uRBI: Int { players.map({$0.uRBI}).total }
    var uNSB: Int { players.map({$0.uNSB}).total }
    //required to use .magnitude because rate stats converted to weighted stats cause negative values
    var uOBP: Double { players.map({$0.uOBP.magnitude}).total }
    var uSLG: Double { players.map({$0.uSLG.magnitude}).total }
    var apa: Hitter {
        Hitter(
            nm: "apa\(pos.rawValue)",
            mlbTm: "nil",
            strPos: pos.rawValue,
            priPos: pos,
            pID: "nil",
            PA: Int(players.map({$0.PA}).average),
            AB: Int(players.map({$0.AB}).average),
            wRAA: players.map({$0.wRAA}).average,
            wOBA: players.map({$0.wOBA}).average,
            HR: Int(players.map({$0.HR}).average),
            R: Int(players.map({$0.R}).average),
            RBI: Int(players.map({$0.RBI}).average),
            NSB: Int(players.map({$0.NSB}).average),
            OBP: players.map({$0.OBP}).average,
            SLG: players.map({$0.SLG}).average
        )
    }
    
    mutating func playerDrafted(hitter: Player) {
        self.players.removeAll(where: {$0.playerid == hitter.playerid})
    }
}
struct PlayerPoolPitcher {
    var players: [Pitcher] = []
    let pos: POS
    var uIP: Int { players.map({$0.uIP}).total }
    var uQS: Int { players.map({$0.uQS}).total }
    var uSVHD: Int { players.map({$0.uSVHD}).total }
    //required to use .magnitude because rate stats converted to weighted stats cause negative values
    var uERA: Double { players.map({$0.uERA.magnitude}).total }
    var uWHIP: Double { players.map({$0.uWHIP.magnitude}).total }
    var uKp9: Double { players.map({$0.uKp9.magnitude}).total }
    var apa: Pitcher {
        Pitcher(
            nm: "apa\(pos.rawValue)",
            mlbTm: "nil",
            strPos: pos.rawValue,
            pID: "nil",
            priPos: pos,
            wFIP: players.map({$0.wFIP}).average,
            FIP: players.map({$0.FIP}).average,
            IP: Int(players.map({$0.IP}).average),
            QS: Int(players.map({$0.QS}).average),
            SVHD: Int(players.map({$0.SVHD}).average),
            ERA: players.map({$0.ERA}).average,
            WHIP: players.map({$0.WHIP}).average,
            Kp9: players.map({$0.Kp9}).average
        )
    }
    
    mutating func playerDrafted(pitcher: Player) {
        self.players.removeAll(where: {$0.playerid == pitcher.playerid})
    }
}
