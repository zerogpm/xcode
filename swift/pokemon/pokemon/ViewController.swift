//
//  ViewController.swift
//  pokemon
//
//  Created by Jian Su on 1/3/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    var pokemon = [PokeMon]()
    var filterPokemon = [PokeMon]()
    var musicPlayer: AVAudioPlayer!
    @IBOutlet weak var searchBar: UISearchBar!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        initAudio()
        parsePokemonCSV()
    }
    
    @IBAction func musicBtnPressed(sender: UIButton!) {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string:path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.description)
        }
    }
    
    func parsePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = PokeMon(name: name, pokededId: pokeId)
                pokemon.append(poke)
            }
            
        } catch let err as NSError {
            print(err.description)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let poke: PokeMon!
            
            if inSearchMode {
                poke = filterPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            
            cell.configureCell(poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke: PokeMon!
        
        if inSearchMode {
            poke = filterPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokeMonDetailVC", sender: poke)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokeMonDetailVC" {
            if let detailVC  = segue.destinationViewController as? PokeMonDetailVC {
                if let poke = sender as? PokeMon {
                    detailVC.pokemon = poke
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filterPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString
            filterPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
        }
    }
    
    /**
        As of iOS 7.0, all view controllers set their own status bar style by default, which means they can have black text or white text depending on what looks best for your view controller. If you want to have light text in the status bar, add this code to your view controller:
    **/
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    

}

