//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Igor Vaz on 24/11/16.
//  Copyright © 2016 Igor Vaz. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 10
        
    }
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        pokemonNameLabel.text = self.pokemon.name.capitalized
        pokemonImageView.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
    
}
