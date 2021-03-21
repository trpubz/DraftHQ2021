//
//  Data.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/3/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

//var league: League = League()
//initial budgets, must be declared globally so players can reference them before var league has finished initializing
let iHBudget: Double = (15 * 260) * 0.60 //hitters are 60% of budget
var bHR: Double { iHBudget * 0.20 }
var bR: Double { iHBudget * 0.18 }
var bRBI: Double { iHBudget * 0.17 } //RBI are discounted because hard to predict who gets on base ahead of you
var bNSB: Double { iHBudget * 0.05 } //5% allocation means soft punting category
var bOBP: Double { iHBudget * 0.20 }
var bSLG: Double { iHBudget * 0.20 }

let iPBudget: Double = (15 * 260) * 0.40 //SP are 28% of budget//RP are 12% of budget
var bIP: Double { iPBudget * 0.20 }
var bQS: Double { iPBudget * 0.20 }
var bSVHD: Double { iPBudget * 0.20 }
var bERA: Double { iPBudget * 0.15 }
var bWHIP: Double { iPBudget * 0.20 }
var bKp9: Double { iPBudget * 0.25 }
//the Pitcher budget category % totals > 100% because QS and SVHD are mutually exclusive

enum Categories: String {
    case OVR, HIT, PIT
    case HR, R, RBI, NSB, OBP, SLG
    case IP, QS, SVHD, ERA, WHIP
    case Kp9 = "K/9"
}

func logEvent(_ s: String) {
    print("\(Date().debugDescription): " + s)
}

