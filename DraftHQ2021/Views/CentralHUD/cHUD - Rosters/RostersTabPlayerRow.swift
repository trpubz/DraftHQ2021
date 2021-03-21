//
//  RostersTabPlayerRow.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/19/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct RostersTabPlayerRow: View {
    var rosterSlot: (key: Team.RosterSlot, value: Player)!
    var apa: Bool {
        if rosterSlot.value.name.starts(with: "apa") {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        HStack {
            Text(rosterSlot.key.rawValue)
                .padding(0.0)
                .rosterPanelWidth(forColumn: .Pos)
            Text(rosterSlot.value.name)
                .lineLimit(1)
                .padding(0.0)
                .foregroundColor(apa ? .secondary : .primary)
                .rosterPanelWidth(forColumn: .Name)
        }
        .frame(width: 175.0)
    }
}

struct RostersTabPlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        RostersTabPlayerRow(rosterSlot: League().teams[0].roster.first(where: {$0.key == .OF1}))
    }
}
