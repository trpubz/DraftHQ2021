//
//  LoadLeague.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 3/18/21.
//

import Foundation

// MARK: - Loading functions
extension League {
    func loadTeams() { //reference Team.swift
        let data: Data
        
        guard let file = Bundle.main.url(forResource: "teams", withExtension: "json")
            else {
                fatalError("Couldn't find teams.json in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load teams.json from main bundle:\n\(error)")
        }

        let tempTeams: [Team] = try! JSONDecoder().decode([Team].self, from: data)
        for t in tempTeams {
            self.teams.append(t)
        }
    }
    
    func loadHitters() { //reference Player.swift
        let data: Data
        
        guard let file = Bundle.main.url(forResource: "hitters", withExtension: "json")
            else {
                fatalError("Couldn't find hitters.json in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load hitters.json from main bundle:\n\(error)")
        }

        let tempHitters: [Hitter] = try! JSONDecoder().decode([Hitter].self, from: data)
        for h in tempHitters {
            self.hitters.append(h)
        }
    }
    
    func loadPitchers() { //reference Player.swift
        let data: Data
        
        guard let file = Bundle.main.url(forResource: "pitchers", withExtension: "json")
            else {
                fatalError("Couldn't find pitchers.json in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load pitchers.json from main bundle:\n\(error)")
        }

        let tempPitchers: [Pitcher] = try! JSONDecoder().decode([Pitcher].self, from: data)
        for p in tempPitchers {
            self.pitchers.append(p)
        }
    }
}
