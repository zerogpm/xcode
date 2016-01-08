//
//  PokeMon.swift
//  pokemon
//
//  Created by Jian Su on 1/3/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation
import Alamofire

class PokeMon {
    private var _name:String!
    private var _pokedeId:Int!
    private var _descritpion:String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _baseAttack:String!
    private var _evolution:String!
    private var _pokeMonUrl:String!
    
    var name:String {
        return _name
    }
    
    var pokedeId:Int {
        return _pokedeId
    }
    
    init(name:String, pokededId:Int) {
        self._name = name
        self._pokedeId = pokededId
        _pokeMonUrl = "\(URL_BASE)\(URL_POKENMON)\(self._pokedeId)/"
    }
    
    func downloadingPokeMonDetails(completed: DownloadComplete) {
        let url = NSURL(string: self._pokeMonUrl)!
        Alamofire.request(.GET, url).responseJSON {
            response in let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._baseAttack)
                print(self._defense)
                print(result.value.debugDescription)
            }
            
        }
    }
}