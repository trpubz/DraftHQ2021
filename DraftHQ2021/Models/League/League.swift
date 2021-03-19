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
        loadTeams()
        
        loadHitters()
        setHitterModels() //sorts arrays on wRAA
        //1st iteration
        iterativeHitterValueSetStack(sortDHOn: "wRAA") //required for first value set because shekel value have not yet been generated
        //reiterate Hitter value set stack
        iterativeHitterValueSetStack(sortDHOn: "shekels")
        iterativeHitterValueSetStack(sortDHOn: "shekels")
        
        loadPitchers()
        setPitcherModels()
        iterativePitcherValueSetStack()
        iterativePitcherValueSetStack()
        iterativePitcherValueSetStack()

        instantiateRosters()
    }
}

// MARK: - getters
extension League {
    func setLeagueShekels() {
        leagueShekels = teams.map({$0.budget}).total
    }
}
// MARK: - Value Setting **Stack** Functions for Hitters
extension League {
    func iterativeHitterValueSetStack(sortDHOn: String) {
        establishHitterRLPandPP()
        establishDHGroup(on: sortDHOn)
        establishVAR_HIT() //sorts arrays on shekels
    }
}
extension League {
    // MARK: - Assign all hitters to their primary position ingested on a wRAA sort
    func setHitterModels() {
        logEvent("League.swfit/func setHitterModels - setting hitter models")
        for h in hitters {
            let positions: [Substring] = h.strPos.split(separator: "/")
            var posRnks: [POS: Double] = [POS: Double]() //store the position and the rank associated
            for pos in positions {
                //assing rank values to each hitter, Doubles are required for players with multi position eligibility
                switch POS(rawValue: String(pos)) {
                case .OF:
                    posRnks[.OF] = Double(allOF.count / 3) + 1.8
                case .C:
                    posRnks[.C] = Double(allC.count) + 1.2
                case .IF1B:
                    posRnks[.IF1B] = Double(all1B.count) + 1.3
                case .IF2B:
                    posRnks[.IF2B] = Double(all2B.count) + 1.4
                case .IF3B:
                    posRnks[.IF3B] = Double(all3B.count) + 1.5
                case .SS:
                    posRnks[.SS] = Double(allSS.count) + 1.6
                case .DH:
                    posRnks[.DH] = Double(allDH.count) + 1.9
                default:
                    print("\(h.name) - \(pos) has no home")
                }
            }
            //determine the highest ranks for each positiona then assign it to the hitter object
            let priPos: POS = posRnks.min(by: { a, b in a.value < b.value })!.key //min symbolizes highest rank
            h.priPos = priPos
            //once hitter has primary position, assign that hitter to the appropriate group of hitters
            switch priPos {
            case .OF: allOF.append(h)
            case .C: allC.append(h)
            case .IF1B: all1B.append(h)
            case .IF2B: all2B.append(h)
            case .IF3B: all3B.append(h)
            case .SS: allSS.append(h)
            case .DH: allDH.append(h)
            default: print(h.name + " not assigned to any position array")
            }
        }
    }
    
    func establishHitterRLPandPP() {
        logEvent("League.swift/func establishHitterRLPandPP - establishing hitter RLP and PPs")
        allDH.removeAll(where: { $0.priPos! != .DH }) //refreshes the DH list to make it clean
        var rlp: RLPHitter
        var backendSlice: ArraySlice<Hitter>
        //OF
        backendSlice = allOF[36...48]
        rlp = RLPHitter(pos: .OF, withHitters: Array(backendSlice))
        assignHitterRLP(to: allOF, with: rlp)
        self.allDH.append(contentsOf: backendSlice)
        self.ppOF.players = Array(allOF[0...35])
        //C
        backendSlice = allC[12...16]
        rlp = RLPHitter(pos: .C, withHitters: Array(backendSlice))
        assignHitterRLP(to: allC, with: rlp)
        self.allDH.append(contentsOf: backendSlice)
        self.ppC.players = Array(allC[0...11])
        //1B
        backendSlice = all1B[12...16]
        rlp = RLPHitter(pos: .IF1B, withHitters: Array(backendSlice))
        assignHitterRLP(to: all1B, with: rlp)
        self.allDH.append(contentsOf: backendSlice)
        self.pp1B.players = Array(all1B[0...11])
        //2B
        backendSlice = all2B[12...16]
        rlp = RLPHitter(pos: .IF2B, withHitters: Array(backendSlice))
        assignHitterRLP(to: all2B, with: rlp)
        self.allDH.append(contentsOf: backendSlice)
        self.pp2B.players = Array(all2B[0...11])
        //3B
        backendSlice = all3B[12...16]
        rlp = RLPHitter(pos: .IF3B, withHitters: Array(backendSlice))
        assignHitterRLP(to: all3B, with: rlp)
        self.allDH.append(contentsOf: backendSlice)
        self.pp3B.players = Array(all3B[0...11])
        //SS
        backendSlice = allSS[12...16]
        rlp = RLPHitter(pos: .SS, withHitters: Array(backendSlice))
        assignHitterRLP(to: allSS, with: rlp)
        self.allDH.append(contentsOf: backendSlice)
        self.ppSS.players = Array(allSS[0...11])
    }
    
    func establishDHGroup(on: String) {
        var rlp: RLPHitter
        var backendSlice: ArraySlice<Hitter>
        switch on {
        case "wRAA":
            allDH.sort(by: {$0.wRAA >  $1.wRAA})
        case "shekels":
            allDH.sort(by: {$0.shekels >  $1.shekels})
        default:
            logEvent("allDH not properly sorted, no match for 'sort-on' string.")
        }
        //DH
        backendSlice = allDH[12...16]
        rlp = RLPHitter(pos: .DH, withHitters: Array(backendSlice))
        assignHitterRLP(to: allDH, with: rlp)
        self.ppDH.players = Array(allDH[0...11])
    }
    
    func establishVAR_HIT() {
        logEvent("League.swift/func establishVAR_HIT - establishing hitter VARs")
        for kvpH in allHittersByPriPos {
            let kvpPos: POS = kvpH.key
            for h in kvpH.value { h.setUsefulWeightedValue(with: ppHitters) }
            
            switch kvpPos {
            case .C:
                allC.sort(by: {$0.shekels > $1.shekels})
                removeDraftablePlayerFromDHs(residingIn: allC)
            case .IF1B:
                all1B.sort(by: {$0.shekels > $1.shekels})
                removeDraftablePlayerFromDHs(residingIn: all1B)
            case .IF2B:
                all2B.sort(by: {$0.shekels > $1.shekels})
                removeDraftablePlayerFromDHs(residingIn: all2B)
            case .IF3B:
                all3B.sort(by: {$0.shekels > $1.shekels})
                removeDraftablePlayerFromDHs(residingIn: all3B)
            case .SS:
                allSS.sort(by: {$0.shekels > $1.shekels})
                removeDraftablePlayerFromDHs(residingIn: allSS)
            case .OF:
                allOF.sort(by: {$0.shekels > $1.shekels})
                removeDraftablePlayerFromDHs(residingIn: allOF)
            case .DH:
                allDH.sort(by: {$0.shekels > $1.shekels})
            default: break
            }
        }
    }
    
    func removeDraftablePlayerFromDHs(residingIn: [Hitter]) {
        var pos: POS { residingIn[0].priPos! }
        var uBound: Int {
            if pos == .OF {
                return 35
            } else {
                return 11
            }
        }
        
        for i in (0...uBound) {
            self.allDH.removeAll(where: { residingIn[i].playerid == $0.playerid })
        }
    }
    
    func assignHitterRLP(to: [Hitter], with rlp: RLPHitter) {
        for h in to {
            h.rlp = rlp
        }
    }
}
// MARK: - Pitcher **Stack** Functions
extension League {
    func iterativePitcherValueSetStack() {
        establishPitcherRLPandPP()
        establishVAR_PIT()
    }
}
extension League {
    func setPitcherModels() {
        logEvent("League.swfit/func setPitcherModels - setting pitcher models")
        for p in pitchers {
            let positions: [Substring] = p.strPos.split(separator: "/")
            var posRnks: [POS: Double] = [POS: Double]() //store the position and the rank associated
            for pos in positions {
                //assing rank values to each hitter, Doubles are required for players with multi position eligibility
                switch POS(rawValue: String(pos)) {
                case .SP, .RP:
                    if p.QS > p.SVHD || p.IP > 100 {
                        posRnks[.SP] = 1
                    } else {
                        posRnks[.RP] = 1
                    }
                default:
                    print("\(p.name) - \(pos) has no home")
                }
            }
            //determine the highest ranks for each positiona then assign it to the hitter object
            let priPos: POS = posRnks.popFirst()!.key //should only be 1 kvpair
            p.priPos = priPos
            //once pitcher has primary position, assign that pitcher to the appropriate group of pitchers
            switch priPos {
            case .SP: allSP.append(p)
            case .RP: allRP.append(p)
            default: print(p.name + " not assigned to any position array")
            }
        }
    }
    
    func establishPitcherRLPandPP() {
        logEvent("League.swift/func establishPitcherRLPandPP - establishing pitcher RLP and PPs")
        var rlp: RLPPitcher
        var backendSlice: ArraySlice<Pitcher>
        //SP
        backendSlice = allSP[60...72]
        rlp = RLPPitcher(pos: .SP, withPitchers: Array(backendSlice))
        assignPitcherRLP(to: allSP, with: rlp)
        self.ppSP.players = Array(allSP[0...59])
        //RP
        backendSlice = allRP[24...31]
        rlp = RLPPitcher(pos: .RP, withPitchers: Array(backendSlice))
        assignPitcherRLP(to: allRP, with: rlp)
        self.ppRP.players = Array(allRP[0...23])
    }
    
    func establishVAR_PIT() {
        logEvent("League.swift/func establishVAR_PIT - establishing hitter VARs")
        for kvpP in allPitchersByPriPos { //key value pair
            let kvpPos: POS = kvpP.key
            for p in kvpP.value { p.setUsefulWeightedValue(with: ppPitchers) }
            
            switch kvpPos {
            case .SP:
                allSP.sort(by: {$0.shekels > $1.shekels})
            case .RP:
                allRP.sort(by: {$0.shekels > $1.shekels})
            default:
                print("should never print")
                break
            }
        }
    }
    
    func assignPitcherRLP(to: [Pitcher], with rlp: RLPPitcher) {
        for p in to {
            p.rlp = rlp
        }
    }
}


