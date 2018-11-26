//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mike Milord on 09/12/2017.
//  Copyright © 2017 First Republic. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    // Create our properties
    private var _name: String!
    private var _pokedexId: Int!
    private var _height: Int!
    private var _weight: Int!
    private var _speed: Int!
    private var _attack: Int!
    private var _pokemonURL : String!
    
    
    //Create our getter
    
    var name: String {
        
        if _name == nil {
            _name = ""
        }
        
        return _name
    }
    
    var pokedex: Int {
        
        if _pokedexId == nil {
            _pokedexId = 0
        }
        return _pokedexId
    }
    
    
    var height: Int {
        
        if _height == nil {
            _height = 0
        }
        
        return _height
    }
    
    var weight: Int {
        if _weight == nil {
            _weight = 0
        }
        return _weight
    }
    
    var speed : Int {
        if _speed == nil {
            _speed = 0
        }
        return _speed
    }
    
    var attack : Int {
        if _attack == nil {
            _attack = 0
        }
        return _attack
    }
    
    // We then need to initialise our class
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        //let set the URL to call the API
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedex)/"
        
    }
    
    //Let create the function that will download the data from the API
    
    func downloadPokemonDetail(complete: @escaping DownloadCompleted) {
        
        print(_pokemonURL)
        
        Alamofire.request(_pokemonURL!).responseJSON { (response) in
            
           // print(response.result.value as Any)
            
            if let dict = response.result.value as? Dictionary<String, Any> {
                
                if let weight = dict["weight"] as? Int {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? Int {
                    self._height = height
                }
            }
            
            complete()
        }
        
        
        
    }
    
}
