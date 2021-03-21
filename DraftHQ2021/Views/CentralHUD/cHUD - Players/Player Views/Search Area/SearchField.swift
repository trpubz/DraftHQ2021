//
//  SearchField.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/21/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct SearchField: View {
    @State private var query: String = ""
    @Binding var player: Player?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                TextField("Player Search...", text: $query, onEditingChanged: { editing in
                    if editing {
                        self.player = nil //clear out the player selection if typing
                    } else {
                    }
                }, onCommit: {
                    print("\(self.query) was searched")
                } )
                    .padding(7)
                    .cornerRadius(16)
                    .frame(maxWidth: 216)
                
                if !query.isEmpty {
                    Button(action: {
                        print("\(self.query) searched")
                        
                    }) {
                        Image("magGlassButton")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 20, maxHeight: 20)
                    }
                    .buttonStyle(DefaultButtonStyle())
                    .padding(7)
                    .animation(.default)
                    .frame(maxWidth: 26, maxHeight: 26)
                }
                
                Spacer()
                
            }.frame(alignment: .leading)
            
            if !query.isEmpty && player == nil {
                QueryList(query: $query, player: $player).onDisappear(perform: {self.query = self.player?.name ?? ""})
            }
        }
        
    }
}

struct QueryList: View {
    @EnvironmentObject var league: League
    var players: [Player] { self.league.allPlayers }
    @Binding var query: String
    @Binding var player: Player?
    
    var body: some View {
        List(players.filter({$0.name.lowercased().contains(self.query.lowercased())}), id: \.self, selection: $player) { plyr in
            VStack {
                Text(plyr.name)
                Divider()
            }
        }.frame(minWidth: 16, maxWidth: 175)
    }
}
struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: 1) {
            SearchField(player: .constant(nil))
            
            QueryList(query: .constant(" "), player: .constant(nil))
                
        }.frame(minWidth: 175, maxWidth: 200)
        

    }
}

