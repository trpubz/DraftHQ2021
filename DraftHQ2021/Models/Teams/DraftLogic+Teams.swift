//
//  DraftLogic+Teams.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 3/21/21.
//

import Foundation

// MARK: - draft logic
extension Team {
    func draft(player: Player, forShek: Int) {
        logEvent("DraftLogic+Teams.swift/class Team/func draft -> \(self.tmAbbrv) drafted \(player.name) for: ₪\(forShek)")
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
