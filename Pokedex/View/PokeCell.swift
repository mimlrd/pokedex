//
//  PokeCell.swift
//  Pokedex
//
//  Created by Mike Milord on 17/12/2017.
//  Copyright © 2017 First Republic. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    
    //Let initialise the cell
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //let rounding the corner of the cells
        
        self.layer.cornerRadius = 5.0
    }
    
    
    
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        self.nameLbl.text = self.pokemon.name.capitalized
        self.imgView.image = UIImage(named: "\(self.pokemon.pokedex)")
    }
    
}
