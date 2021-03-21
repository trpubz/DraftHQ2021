//
//  PitchersHandlerLeague.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 3/19/21.
//

import Foundation

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
