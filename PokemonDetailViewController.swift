//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Igor Vaz on 25/11/16.
//  Copyright © 2016 Igor Vaz. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var currentPokemonImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    
    
    
    // MARK: - Variables
    
    var pokemon: Pokemon!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = pokemon.name.capitalized
        mainImage.image = UIImage(named: "\(pokemon.pokedexId)")
        currentPokemonImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails {
            
            self.updateUI()
            
        }
        
    }
    
    
    // MARK: - UI
    
    func updateUI() {
        
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        idLabel.text = "\(pokemon.pokedexId)"
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        evolutionLabel.text = pokemon.nextEvolutionText
        nextEvolutionImage.image = UIImage(named: pokemon.nextEvolutionId)
        
        if pokemon.nextEvolutionId == "" {
            
            evolutionLabel.text = "No evolutions"
            
        } else {
            
            evolutionLabel.text = pokemon.nextEvolutionText
            
        }
        
    }
    

    // MARK: - Actions
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
