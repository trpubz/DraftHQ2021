//
//  League.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 4/17/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import Foundation

class League: ObservableObject {
    @Published var teams: [Team] = []
    var allPlayers: [Player] {
        var players: [Player] = [Player]()
        players.append(contentsOf: hitters)
        players.append(contentsOf: pitchers)
        players.sort(by: {$0.name < $1.name})
        return players
    }
    var hitters: [Hitter] = []
    var allHittersByPriPos: [POS:[Hitter]] { [.C:allC, .IF1B:all1B, .IF2B:all2B, .IF3B:all3B, .SS:allSS, .OF:allOF, .DH:allDH] }
    var allC: [Hitter] = []
    var all1B: [Hitter] = []
    var all2B: [Hitter] = []
    var all3B: [Hitter] = []
    var allSS: [Hitter] = []
    var allOF: [Hitter] = []
    var allDH: [Hitter] = []
    var ppHitters: [POS:PlayerPoolHitter] { [.C: ppC, .IF1B: pp1B, .IF2B: pp2B, .IF3B: pp3B, .SS: ppSS, .OF: ppOF, .DH: ppDH] }
    var ppC = PlayerPoolHitter(pos: .C)
    var pp1B = PlayerPoolHitter(pos: .IF1B)
    var pp2B = PlayerPoolHitter(pos: .IF2B)
    var pp3B = PlayerPoolHitter(pos: .IF3B)
    var ppSS = PlayerPoolHitter(pos: .SS)
    var ppOF = PlayerPoolHitter(pos: .OF)
    var ppDH = PlayerPoolHitter(pos: .DH)
    var pitchers: [Pitcher] = []
    var allPitchersByPriPos: [POS:[Pitcher]] { [.SP:allSP, .RP:allRP] }
    var allSP: [Pitcher] = []
    var allRP: [Pitcher] = []
    var ppPitchers: [POS:PlayerPoolPitcher] { [.SP:ppSP, .RP:ppRP]}
    var ppSP = PlayerPoolPitcher(pos: .SP)
    var ppRP = PlayerPoolPitcher(pos: .RP)
    
    @Published var leagueShekels: Int = 15 * 260 //could be set to 0 because setter function sets this var
    var valueOfUndrafted: Int {
        Int(ppHitters.values.map({$0.players.map({$0.shekels}).total}).total) + Int(ppPitchers.values.map({$0.players.map({$0.shekels}).total}).total)
    }
    var playersDrafted: Int { teams.map({$0.drafted}).total }
    
    var rnksOVR: [String:Int] {
            var totOVRs = [String:Int]()
            for tm in teams {
                totOVRs[tm.tmAbbrv] = Int(tm.HIT + tm.PIT)
            }
    //        let sorted: Array<(key: String, value: Int)> = totHRs.sorted(by: {$0.value > $1.value})
            return big3Rankings(totOVRs.sorted(by: {$0.value < $1.value}))
        }
    var rnksHIT:  [String:Int] {
           var totHITs = [String:Int]()
           for tm in teams {
               totHITs[tm.tmAbbrv] = Int(tm.HIT)
           }
   //        let sorted: Array<(key: String, value: Int)> = totHRs.sorted(by: {$0.value > $1.value})
           return big3Rankings(totHITs.sorted(by: {$0.value < $1.value}))
       }
    var rnksHR: [String:Int] {
        var totHRs = [String:Int]()
        for tm in teams {
            totHRs[tm.tmAbbrv] = tm.totHR
        }
//        let sorted: Array<(key: String, value: Int)> = totHRs.sorted(by: {$0.value > $1.value})
        return rankings(totHRs.sorted(by: {$0.value > $1.value}))
    }
    var rnksR: [String:Int] {
        var totRs = [String:Int]()
            for tm in teams {
                totRs[tm.tmAbbrv] = tm.totR
            }
        return rankings(totRs.sorted(by: {$0.value > $1.value}))
    }
    var rnksRBI: [String:Int] {
        var totRBIs = [String:Int]()
            for tm in teams {
                totRBIs[tm.tmAbbrv] = tm.totRBI
            }
        return rankings(totRBIs.sorted(by: {$0.value > $1.value}))
    }
    var rnksNSB: [String:Int] {
        var totNSBs = [String:Int]()
            for tm in teams {
                totNSBs[tm.tmAbbrv] = tm.totNSB
            }
        return rankings(totNSBs.sorted(by: {$0.value > $1.value}))
    }
    var rnksOBP: [String:Int] {
        var totOBPs = [String:Int]()
            for tm in teams {
                totOBPs[tm.tmAbbrv] = Int(tm.totOBP)
            }
        return rankings(totOBPs.sorted(by: {$0.value > $1.value}))
    }
    var rnksSLG: [String:Int] {
        var totSLGs = [String:Int]()
            for tm in teams {
                totSLGs[tm.tmAbbrv] = Int(tm.totSLG)
            }
        return rankings(totSLGs.sorted(by: {$0.value > $1.value}))
    }
    var rnksPIT: [String:Int] {
        var totPITs = [String:Int]()
        for tm in teams {
            totPITs[tm.tmAbbrv] = Int(tm.PIT)
        }
//        let sorted: Array<(key: String, value: Int)> = totHRs.sorted(by: {$0.value > $1.value})
        return big3Rankings(totPITs.sorted(by: {$0.value < $1.value}))
    }
    var rnksIP: [String:Int] {
        var totIPs = [String:Int]()
            for tm in teams {
                totIPs[tm.tmAbbrv] = tm.totIP
            }
        return rankings(totIPs.sorted(by: {$0.value > $1.value}))
    }
    var rnksQS: [String:Int] {
        var totQSs = [String:Int]()
            for tm in teams {
                totQSs[tm.tmAbbrv] = tm.totQS
            }
        return rankings(totQSs.sorted(by: {$0.value > $1.value}))
    }
    var rnksSVHD: [String:Int] {
        var totSVHDs = [String:Int]()
            for tm in teams {
                totSVHDs[tm.tmAbbrv] = tm.totSVHD
            }
        return rankings(totSVHDs.sorted(by: {$0.value > $1.value}))
    }
    var rnksERA: [String:Int] {
        var totERAs = [String:Int]()
            for tm in teams {
                totERAs[tm.tmAbbrv] = Int(tm.totERA)
            }
        return rankings(totERAs.sorted(by: {$0.value > $1.value}))
    }
    var rnksWHIP: [String:Int] {
        var totWHIPs = [String:Int]()
            for tm in teams {
                totWHIPs[tm.tmAbbrv] = Int(tm.totWHIP)
            }
        return rankings(totWHIPs.sorted(by: {$0.value > $1.value}))
    }
    var rnksKp9: [String:Int] {
        var totKp9s = [String:Int]()
            for tm in teams {
                totKp9s[tm.tmAbbrv] = Int(tm.totKp9)
            }
        return rankings(totKp9s.sorted(by: {$0.value > $1.value}))
    }
    
    init() {
        loadAsset(asset: .teams)
        
        loadAsset(asset: .hitters)
        setHitterModels() //sorts arrays on wRAA
        //1st iteration
        iterativeHitterValueSetStack(sortDHOn: "wRAA") //required for first value set because shekel value have not yet been generated
        //reiterate Hitter value set stack
        iterativeHitterValueSetStack(sortDHOn: "shekels")
        iterativeHitterValueSetStack(sortDHOn: "shekels")
        
        loadAsset(asset: .pitchers)
        setPitcherModels()
        iterativePitcherValueSetStack()
        iterativePitcherValueSetStack()
        iterativePitcherValueSetStack()

        instantiateRosters()
    }
}

// MARK: - getters/setters
extension League {
    func setLeagueShekels() {
        leagueShekels = teams.map({$0.budget}).total
    }
    
    func getLeaguePlayerSize() -> Int {
        return self.teams.count * (9 + 7 + 5)
    }
    
    func getTeamsCount() -> Int {
        return self.teams.count
    }
}

// MARK: - Codeable
extension League {
    enum CodingKeys: CodingKey {
        case teams
    }
    
    enum assets: String {
        case teams
        case hitters
        case pitchers
    }
}



