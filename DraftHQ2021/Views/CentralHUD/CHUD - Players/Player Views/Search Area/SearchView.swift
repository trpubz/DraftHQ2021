//
//  SearchView.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/20/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State var player: Player?
    
    var body: some View {
        VStack {
            SearchField(player: $player)
            
            if player != nil {
                VStack {
                    SearchResults(player: player)
                    
                }
            }
        }
        .frame(maxWidth: 965, alignment: .leading)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(player: league.allOF[0])
            .frame(width: 965)
    }
}
