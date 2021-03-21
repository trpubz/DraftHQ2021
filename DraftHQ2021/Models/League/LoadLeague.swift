//
//  LoadLeague.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 3/18/21.
//

import Foundation

// MARK: - Loading functions
extension League {
    func loadAsset(asset: assets) {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: asset.rawValue, withExtension: "json")
            else {
            fatalError("Couldn't find \(asset).json in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(asset).json from main bundle:\n\(error)")
        }
        
        switch asset {
        case .teams:
            let tempTeams: [Team] = try! JSONDecoder().decode([Team].self, from: data)
            for t in tempTeams {
                self.teams.append(t)
            }
        case .hitters:
            let tempHitters: [Hitter] = try! JSONDecoder().decode([Hitter].self, from: data)
            for h in tempHitters {
                self.hitters.append(h)
            }
        case .pitchers:
            let tempPitchers: [Pitcher] = try! JSONDecoder().decode([Pitcher].self, from: data)
            for p in tempPitchers {
                self.pitchers.append(p)
            }
        }
    }
}
