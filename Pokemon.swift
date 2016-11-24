//
//  Pokemon.swift
//  Pokedex
//
//  Created by Igor Vaz on 24/11/16.
//  Copyright © 2016 Igor Vaz. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    init(name: String, pokedexId: Int) {
        
        _name = name
        _pokedexId = pokedexId
        
    }
    
    var name: String {
        
        return _name
        
    }
    
    var pokedexId: Int {
        
        return _pokedexId
        
    }
    
}
