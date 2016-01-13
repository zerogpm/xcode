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
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                print(self._type)
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                       let nsUrl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsUrl).responseJSON {
                            response in let result = response.result
                            if let descDict = result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._descritpion = description
                                }
                            }
                        }
                        
                    } else {
                        self._descritpion = ""
                    }
                    
                    if let evloutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evloutions.count > 0 {
                        if let to = evloutions[0]["to"] as? String {
                            
                            //Mega is not found
                            if to.rangeOfString("mega") == nil {
                                if let url = evloutions[0]["resource_uri"] as? String {
                                    print(url)
                                }
                            }
                            
                        }
                    }
                }
            }
            
        }
    }
}