//
//  PokeCell.swift
//  pokemon
//
//  Created by Jian Su on 1/3/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    var pokeMon: PokeMon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokeMon:PokeMon) {
        self.pokeMon = pokeMon
        nameLbl.text = self.pokeMon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokeMon.pokedeId)")
    }
}
