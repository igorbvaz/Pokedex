//
//  ViewController.swift
//  Pokedex
//
//  Created by Igor Vaz on 24/11/16.
//  Copyright © 2016 Igor Vaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: -  Variables
    
    var pokemonArray = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var searchMode: Bool = false
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        parsePokemonCSV()
        searchBar.tintColor = UIColor.red
        
    }
    
    
    // MARK: - SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            searchBar.showsCancelButton = false
            searchMode = false
            view.endEditing(true)
            
        } else {
            
            searchBar.showsCancelButton = true
            
            searchMode = true
            let text = searchBar.text?.lowercased()
            filteredPokemon = pokemonArray.filter({ (pokemon: Pokemon) -> Bool in
                
                pokemon.name.range(of: text!) != nil
                
            })
            
        }
        
        collectionView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        view.endEditing(true)
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = true
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        view.endEditing(true)
        searchBar.showsCancelButton = false
        collectionView.reloadData()
        
    }
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell {
            
            var pokemon: Pokemon
            
            if searchMode {
                
                pokemon = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: pokemon)
                
            } else {
                
                pokemon = pokemonArray[indexPath.row]
                cell.configureCell(pokemon: pokemon)
                
            }
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var pokemon: Pokemon!
        
        if searchMode {
            
            pokemon = filteredPokemon[indexPath.row]
            
        } else {
            
            pokemon = pokemonArray[indexPath.row]
            
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: pokemon)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchMode {
            
            return filteredPokemon.count
            
        }
        
        return pokemonArray.count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
        
    }
    
    
    // MARK: - Util
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let pokemonId = Int(row["id"] as! String)!
                let pokemonName = row["identifier"] as! String
                
                let pokemon = Pokemon(name: pokemonName, pokedexId: pokemonId)
                pokemonArray.append(pokemon)
                
            }
            
        } catch {
            
            
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "PokemonDetailVC":
            
            if let viewController = segue.destination as? PokemonDetailViewController {
                
                if let pokemon = sender as? Pokemon {
                    
                    viewController.pokemon = pokemon
                    
                }
                
            }
            break
            
        default:
            break
        }
        
    }
    
}

