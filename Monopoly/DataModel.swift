//
//  DataModel.swift
//  Monopoly
//
//  Created by Rodion Molchanov on 09.03.2021.
//

import Foundation

struct DataModel {
    static var shared = DataModel()
    private var playerArray = [Player]()

    var startMoney: Int64 = 1500
    
    private init() { }
    
    func setPlayerArray(array: [Player]) {
        
    }
    
    func setPlayerArray() {
        
    }
    
    func getPlayerArray() -> [Player] {
        return playerArray
    }
    
    func getPlayer(atIndex: Int) -> Player {
        if atIndex < playerArray.count {
            return playerArray[atIndex]
        }
        return Player(name: "", money: 0)
    }
    
    func getPlayerArrayCount() -> Int {
        return playerArray.count
    }
    
    mutating func addPlayer(player: Player) {
        playerArray.append(player)
    }
    
    mutating func addCleanPlayer() {
        let newPlayer = Player(name: "", money: self.startMoney)
        self.addPlayer(player: newPlayer)
    }
    
    
    mutating func modifyPlayer(name: String?, money: Int64?, atIndex: Int) -> Bool {
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
        return changeFlag
    }
    
    
    mutating func modifyPlayerName(name: String, atIndex: Int) -> Bool {
        return modifyPlayer(name: name, money: nil, atIndex: atIndex)
    }
    
    mutating func modifyPlayerMoney(money: Int64, atIndex: Int) -> Bool {
        return modifyPlayer(name: nil, money: money, atIndex: atIndex)
    }
    
    mutating func deletePlayer(atIndex: Int) -> Bool {
        if !isIndexTrue(index: atIndex) {
            return false
        }
        self.playerArray.remove(at: atIndex)
        return true
    }
    
    func isIndexTrue(index: Int) -> Bool {
        if index >= 0 && index < self.playerArray.count {
            return true
        }
        return false
    }
    
}
