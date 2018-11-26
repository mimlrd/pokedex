//
//  PokemonVC.swift
//  Pokedex
//
//  Created by Mike Milord on 09/12/2017.
//  Copyright © 2017 First Republic. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var pokeCollection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var pokemons = [Pokemon]()
    
    let cellID = "PokeCell"
    
    var musicPlayer : AVAudioPlayer!
    
    //For searching
    var isInSearchingMode = false
    var filteredPokemons = [Pokemon]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        pokeCollection.delegate = self
        pokeCollection.dataSource = self
        searchBar.delegate = self
        
        //Change the button to done
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
        parsePokemonCSC()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playTheAudio()
    }
    
    
    func playTheAudio () {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 // Loop infinetly
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    func parsePokemonCSC() {
        
        // To get the data from the CSV file, first we will need a path
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        //Now we will need a do cathc as we might get some error on parsing the file
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            
            for row in rows {
                
                let pokemon = Pokemon(name: row["identifier"]!, pokedexId: Int(row["id"]!)!)
                
                pokemons.append(pokemon)
                
            }
            
            
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        // Let looking at which mode we are in
        
        var poke : Pokemon!
        
        if isInSearchingMode {
            poke = filteredPokemons[indexPath.row]
        } else {
            poke = pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokeDetailsVC", sender: poke)
    }
    
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isInSearchingMode {
            
            return filteredPokemons.count
        }
        return pokemons.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PokeCell {
            
            let poke : Pokemon!
            
            if isInSearchingMode {
                
                poke = filteredPokemons[indexPath.row]
                
            } else {
                poke = pokemons[indexPath.row]
            }
            
            
        
            cell.configureCell(pokemon: poke)
            
            return cell
        } else {
            
            return UICollectionViewCell()
        }
        
    
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    
    
    //Let search the Pokemon array
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        //Let find out first if we are in the searching mode
        
        if searchBar.text == nil || searchBar.text == ""{
            isInSearchingMode = false
            pokeCollection.reloadData()
            view.endEditing(true)
        } else {
            
            isInSearchingMode = true
        
            //Let change what was typed in lower case
            let lowerCase = searchText.lowercased()
            
            //Now let add the objects from the pokemons array as the user type
            
            filteredPokemons = pokemons.filter({$0.name.range(of: lowerCase) != nil})

            pokeCollection.reloadData()
            
        }
    }
    
    
    //TO make the keyboard go away
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    

    
    @IBAction func playMusic(_ sender: UIButton) {
        
        
        if musicPlayer.isPlaying {
            
            musicPlayer.pause()
            
            sender.alpha = 0.7
        } else {
            
            musicPlayer.play()
            
            sender.alpha = 1.0
        }
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //This is where we are goong to pass all the infos
        
        if segue.identifier == "PokeDetailsVC" {
            
            if let detailsVC = segue.destination as? PokeDetailsVC {
                
                if let poke = sender as? Pokemon {
                    detailsVC.pokemonDetails = poke
                }
                
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        musicPlayer.stop()
    }
    
    

   

}

