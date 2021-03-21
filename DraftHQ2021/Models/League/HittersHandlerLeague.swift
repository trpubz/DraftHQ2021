//
//  HittersHandlerLeague.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 3/19/21.
//

import Foundation

// MARK: - Value Setting **Stack** Functions for Hitters
extension League {
    func iterativeHitterValueSetStack(sortDHOn: String) {
        establishHitterRLPandPP()
        establishDHGroup(on: sortDHOn)
        establishVAR_HIT() //sorts arrays on shekels
    }
}
extension League {
    // Assign all hitters to their primary position ingested on a wRAA sort
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
