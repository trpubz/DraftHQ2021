//
//  TeamHUD.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/4/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct TeamHUD: View {
    @ObservedObject var team: Team
    
    var body: some View {
        
        HStack() {
            VStack(spacing: 0.10) {
                Text(team.tmAbbrv).font(.headline)
                VStack(alignment: .leading) {
                    Text(team.teamName)
                    Text(team.owner)
                }
            }
            .padding([.leading, .bottom], 3.0)
            .frame(width: 100)
            
            VStack(alignment: .leading) {
                Text(team.rosterToString)
                Text(team.projRecordToString)
            }
            Divider().padding(.vertical)
            HStack {
                VStack {
                    Text("OVR").font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                    Text("\(team.rnkOVR)").font(.title)
                }
                Spacer()
                VStack {
                    Text("HIT").font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                    Text("\(team.rnkHIT)").font(.title)
                }
                Spacer()
                VStack {
                    Text("PIT").font(/*@START_MENU_TOKEN@*/.subheadline/*@END_MENU_TOKEN@*/)
                    Text("\(team.rnkPIT)").font(.title)
                }
            }
            .frame(width: 116.0)
        
        }
        .frame(width: 330.0, height: 55.0)

        //.border(Color.black)

        
    }
}

struct TeamHUD_Previews: PreviewProvider {
    static var previews: some View {
        TeamHUD(team: league.teams[0])
    }
}
