//
//  PokeAnnotation.swift
//  pokemonSurprise
//
//  Created by Jian Su on 2016-08-02.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit
import MapKit

class PokeAnnotation: NSObject, MKAnnotation{
  
  let coordinate:CLLocationCoordinate2D
  let pokemonNumber:Int
  let pokemonName: String
  let title:String?
  
  init(coordinate:CLLocationCoordinate2D, pokemonNumber:Int, pokemonName:String) {
    self.coordinate = coordinate
    self.pokemonNumber = pokemonNumber
    self.pokemonName = pokemonName
    self.title = self.pokemonName
  }
  
}

