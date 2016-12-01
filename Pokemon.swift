//
//  Pokemon.swift
//  Pokedex
//
//  Created by Igor Vaz on 24/11/16.
//  Copyright © 2016 Igor Vaz. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionId: String!
    private var _pokemonUrl: String!
    
    init(name: String, pokedexId: Int) {
        
        _name = name
        _pokedexId = pokedexId
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(_pokedexId!)"
        
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonUrl).responseJSON { (response: DataResponse<Any>) in
            
            let result = response.result
            if let json = result.value as? Dictionary<String, Any> {
                
                if let weight = json["weight"] as? String {
                    
                    self._weight = weight
                    
                }
                
                if let height = json["height"] as? String {
                    
                    self._height = height
                    
                }
                
                if let attack = json["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                    
                }
                
                if let defense = json["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                    
                }

                if let types = json["types"] as? [Dictionary<String, String>], types.count > 0 {
                    
                    if let type = types[0]["name"] {
                        
                        self._type = type.capitalized
                        
                    }
                    
                    if types.count > 1 {
                        
                        for index in 1..<types.count {
                            
                            self._type! += " / \(types[index]["name"]!.capitalized)"
                            
                        }
                        
                    }
                    
                } else {
                    
                    self._type = ""
                    
                }
                
                if let descriptions = json["descriptions"] as? [Dictionary<String, String>], descriptions.count > 0 {
                    
                    if let uri = descriptions[0]["resource_uri"] {
                        print("Uri: \(uri)")
                        let url = "\(URL_BASE)\(uri)"
                        
                        Alamofire.request(url).responseJSON(completionHandler: { (response: DataResponse<Any>) in

                            if let json = response.result.value as? Dictionary<String, Any> {

                                if let description = json["description"] as? String {
                                    print(description)
                                    self._description = description
                                    
                                }
                                
                            }
                            
                            completed()
                            
                        })
                        
                    }
                    
                } else {
                    
                    self._description = ""
                    
                }
                
                if let evolutions = json["evolutions"] as? [Dictionary<String, Any>], evolutions.count > 0 {
                    
                    if let nextEvolutionName = evolutions[0]["to"] as? String {
                        
                        if nextEvolutionName.range(of: "mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let str = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvolutionId = str.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvolutionId
                                
                                if let nextEvolutionLevel = evolutions[0]["level"] as? Int {
                                    
                                    self._nextEvolutionText = "Next evolution: \(nextEvolutionName) at level: \(nextEvolutionLevel)"
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                } else {
                    
                    self._nextEvolutionText = "No evolution"
                    
                }
                
            }
            
        }
        
    }

    var name: String {
        
        return _name
        
    }
    
    var pokedexId: Int {
        
        return _pokedexId
        
    }
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
            
        }
        
        return _description
        
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = ""
            
        }
        
        return _type
        
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = ""
            
        }
        
        return _defense
        
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = ""
            
        }
        
        return _height
        
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
            
        }
        
        return _weight
        
    }
    
    var attack: String {
        
        if _attack == nil {
         
            _attack = ""
            
        }
        
        return _attack
        
    }
    
    var nextEvolutionText: String {
        
        if _nextEvolutionText == nil {
            
            _nextEvolutionText = ""
            
        }
        
        return _nextEvolutionText
        
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            
            _nextEvolutionId = ""
            
        }
        
        return _nextEvolutionId
        
    }
    
}
