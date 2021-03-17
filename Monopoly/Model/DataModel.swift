//
//  DataModel.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 09.03.2021.
//

import Foundation
import UIKit

struct DataModel {
    static var shared = DataModel()
    private var playerArray = [Player]()
    
    private init() { }
        
    func getPlayerArray() -> [Player] {
        return playerArray
    }
    
    func getPlayer(atIndex: Int) -> Player? {
        if atIndex < playerArray.count {
            return playerArray[atIndex]
        }
        return nil
    }
    
    func getPlayerArrayCount() -> Int {
        return playerArray.count
    }
    
    mutating func addPlayer(player: Player) {
        playerArray.append(player)
    }

    mutating func modifyPlayer(name: String?, money: Int64?, image: UIImage?, atIndex: Int) -> Bool {
        if !isIndexTrue(index: atIndex) {
            return false
        }
        var changeFlag = false
        if let name = name {
            self.playerArray[atIndex].name = name
            changeFlag = true
        }
        if let money = money {
            self.playerArray[atIndex].money = money
            changeFlag = true
        }
        if let image = image {
            self.playerArray[atIndex].image = image
            changeFlag = true
        }
        return changeFlag
    }
    
    mutating func deletePlayer(atIndex: Int) -> Bool {
        if !isIndexTrue(index: atIndex) {
            return false
        }
        self.playerArray.remove(at: atIndex)
        return true
    }
    
    private func isIndexTrue(index: Int) -> Bool {
        if index >= 0 && index < self.playerArray.count {
            return true
        }
        return false
    }
    
}
