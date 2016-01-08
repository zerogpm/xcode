//
//  PokeMonDetailVC.swift
//  pokemon
//
//  Created by Jian Su on 1/4/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit

class PokeMonDetailVC: UIViewController {

    
    @IBOutlet weak var pokeNameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heighLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evolutionTxt: UILabel!
    
    var pokemon: PokeMon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokeNameLbl.text = pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedeId)")
        pokemon.downloadingPokeMonDetails { () -> () in
            //This will be call after download is done
        }
    }

    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
