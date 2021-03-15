//
//  RowExpandButton.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/13/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct RowExpandButton: View {
    @ObservedObject var player: Player
    @Binding var rowState: PlayerRowState
    @State private var hoverState = false
    
    var body: some View {
        Button(action: {
            if self.rowState == .inline {
                self.rowState = .expanded
            } else if self.rowState == .expanded {
                self.rowState = .inline
            }
            print(self.player.name + " row \(self.rowState.rawValue).")
        }) {
            if rowState == .inline {
                Image(hoverState ? imgRowExpandBtn.chevronHover.rawValue : imgRowExpandBtn.chevronInline.rawValue)
                    .resizable()
                    .scaledToFit()
            } else if rowState == .expanded {
                Image(imgRowExpandBtn.chevronExpanded.rawValue)
                    .resizable()
                    .scaledToFit()
            }
        }
            .buttonStyle(PlainButtonStyle())
            .onHover(perform: { hover in
                self.hoverState = hover
            })
            .frame(width: 33, height: 16)
            .animation(.default)
    
    }
}

enum imgRowExpandBtn: String {
    case chevronHover, chevronInline, chevronExpanded
}

struct DraftButton_Previews: PreviewProvider {
    static var previews: some View {
        RowExpandButton(player: league.hitters[0], rowState: .constant(.inline))
    }
}

