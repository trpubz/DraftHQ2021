//
//  DraftLeague.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 3/18/21.
//

import Foundation

// MARK: - Drafting Logic
//instantiates rosters with Average Player Architypes
extension League {
    func instantiateRosters() {
        let numberOfTeams = teams.count
        for i in 0...numberOfTeams - 1 {
            teams[i].instantiateRoster(withLeague: self)
        }
        
        updateTeamRanks()
        projectRecords()
    }
}
//projects records
extension League {
    func playerDrafted(_ p: Player, by drafter: Team, forShek: Int) {
//        logEvent("League.swift/struct League/func playerDrafted - \(p.name) drafted by \(by.tmAbbrv) for: ₪\(forShek)")
        drafter.draft(player: p, forShek: forShek)
        //update the player pools by removing that player
        switch p.priPos {
        case .C: ppC.playerDrafted(hitter: p)
        case .IF1B: pp1B.playerDrafted(hitter: p)
        case .IF2B: pp2B.playerDrafted(hitter: p)
        case .IF3B: pp3B.playerDrafted(hitter: p)
        case .SS: ppSS.playerDrafted(hitter: p)
        case .OF: ppOF.playerDrafted(hitter: p)
        case .DH: ppDH.playerDrafted(hitter: p)
        case .SP: ppSP.playerDrafted(pitcher: p)
        case .RP: ppRP.playerDrafted(pitcher: p)
        default: print("League.swift/func playerDrafted/default: won't print")
        }
        
        for tm in teams {
            if tm != drafter {
                switch p.priPos {
                case .C: tm.updateAPA(ppHIT: ppC)
                case .IF1B: tm.updateAPA(ppHIT: pp1B)
                case .IF2B: tm.updateAPA(ppHIT: pp2B)
                case .IF3B: tm.updateAPA(ppHIT: pp3B)
                case .SS: tm.updateAPA(ppHIT: ppSS)
                case .OF: tm.updateAPA(ppHIT: ppOF)
                case .DH: tm.updateAPA(ppHIT: ppDH)
                case .SP: tm.updateAPA(ppPIT: ppSP)
                case .RP: tm.updateAPA(ppPIT: ppRP)
                default: print("League.swift/func playerDrafted/default: won't print")
                }
            }
        }
        
        setLeagueShekels()
        updateTeamRanks()
        projectRecords()
    }
    
    func projectRecords() {
        teams.forEach({$0.resetRecord()})
        
        for i in 0...10 {
            for j in i + 1...11 {
                if j > i {
                    H2H_Handler(teams[i], vs: teams[j])
                }
            }
        }
        logEvent("League.swift/func projectRecords - finished projecting records")
    }
    
    func H2H_Handler(_ tm1: Team, vs tm2: Team) {
        //HR
        if tm1.rnkHR < tm2.rnkHR {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkHR > tm2.rnkHR {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkHR == tm2.rnkHR {
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //R
        if tm1.rnkR < tm2.rnkR {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkR > tm2.rnkR {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkR == tm2.rnkR{
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //RBI
        if tm1.rnkRBI < tm2.rnkRBI {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkRBI > tm2.rnkRBI {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkRBI == tm2.rnkRBI {
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //NSB
        if tm1.rnkNSB < tm2.rnkNSB {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkNSB > tm2.rnkNSB {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkNSB == tm2.rnkNSB {
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //OBP
        if tm1.rnkOBP < tm2.rnkOBP {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkOBP > tm2.rnkOBP {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkOBP == tm2.rnkOBP {
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //SLG
        if tm1.rnkSLG < tm2.rnkSLG {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkSLG > tm2.rnkSLG {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkSLG == tm2.rnkSLG {
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //IP
        if tm1.rnkIP < tm2.rnkIP {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkIP > tm2.rnkIP {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkIP == tm2.rnkIP {
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //QS
        if tm1.rnkQS < tm2.rnkQS {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkQS > tm2.rnkQS {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkQS == tm2.rnkQS{
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //SVHD
        if tm1.rnkSVHD < tm2.rnkSVHD {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkSVHD > tm2.rnkSVHD {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkSVHD == tm2.rnkSVHD {
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //ERA
        if tm1.rnkERA < tm2.rnkERA {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkERA > tm2.rnkERA {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkERA == tm2.rnkERA {
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //WHIP
        if tm1.rnkWHIP < tm2.rnkWHIP {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkWHIP > tm2.rnkWHIP {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkWHIP == tm2.rnkWHIP {
            tm1.tmT += 1
            tm2.tmT += 1
        }
        //K/9
        if tm1.rnkKp9 < tm2.rnkKp9 {
            tm1.tmW += 1
            tm2.tmL += 1
        } else if tm1.rnkKp9 > tm2.rnkKp9 {
            tm1.tmL += 1
            tm2.tmW += 1
        } else if tm1.rnkKp9 == tm2.rnkKp9 {
            tm1.tmT += 1
            tm2.tmT += 1
        }
    }
    
    func updateTeamRanks() {
        //the rnksSTAT object is a [String:Int] dictionary where the key is the tmAbbrv and the value is the rank
        //the dictionary is a computed property that has already determined the rank for each category based on team's totals
        for rnk in rnksHR { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkHR = rnk.value }
        for rnk in rnksR { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkR = rnk.value }
        for rnk in rnksRBI { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkRBI = rnk.value }
        for rnk in rnksNSB { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkNSB = rnk.value }
        for rnk in rnksOBP { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkOBP = rnk.value }
        for rnk in rnksSLG { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkSLG = rnk.value }
        for rnk in rnksHIT { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkHIT = rnk.value }
        for rnk in rnksIP { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkIP = rnk.value }
        for rnk in rnksQS { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkQS = rnk.value }
        for rnk in rnksSVHD { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkSVHD = rnk.value }
        for rnk in rnksERA { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkERA = rnk.value }
        for rnk in rnksWHIP { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkWHIP = rnk.value }
        for rnk in rnksKp9 { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkKp9 = rnk.value }
        for rnk in rnksPIT { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkPIT = rnk.value }
        for rnk in rnksOVR { teams.first(where: {$0.tmAbbrv == rnk.key})!.rnkOVR = rnk.value }
    }
}
