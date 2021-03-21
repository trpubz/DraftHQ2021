//
//  ContentView.swift
//  DraftAssistant2020
//
//  Created by Taylor Pubins on 4/17/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct Dashboard: View {
    @EnvironmentObject var league: League
    @State var filter: POS = .OF
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Spacer()
                LeagueHUD()
                Spacer()
                Divider()
                    .padding(.vertical)
                Spacer()
                MyTeamHUD()
                Spacer()
            }.frame(height: 100)
            Divider()
            HStack {
                TeamHUDsLeague()
                Divider()
                    .padding(.vertical)
                //central player region
                VStack {
                    CentralHUD()
                    
                }
                Divider()
                .padding(.vertical)
                
                VStack {
                    MyRosterView()
                    Spacer()
                }
            }
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
            .environmentObject(League())
    }
}

enum PosFilter: Hashable {
    case ALL
    case C
    case IF1B
    case IF2B
    case IF3B
    case IFSS
    case OF
    case DH
}
