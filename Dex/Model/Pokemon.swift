//
//  Pokemon.swift
//  Dex
//
//  Created by Hriday Chhabria on 2/26/21.
//

import Foundation
import UIKit

struct Pokemon {
    
    var name = ""
    var type = ""
    var category = ""
    var story = ""
    var imageName = ""
    
    init(name: String) {
        self.name = name
        setInfo()
    }
    
    mutating func setInfo(){
        switch name {
        case "Pikachu":
            imageName = "pik"
            type = "Electric"
            category = "Mouse"
            story = "Pikachu that can generate powerful electricity have cheek sacs that are extra soft and super stretchy"
        case "Charmander":
            imageName = "char"
            type = "Fire"
            category = "Lizard"
            story = "From the time it is born, a flame burns at the tip of its tail. Its life would end if the flame were to go out"
        case "Squirtle":
            imageName = "squirt"
            type = "Water"
            category = "Tiny Turtle"
            story = "When it retracts its long neck into its shell, it squirts out water with vigorous force"
        case "Bulbasaur":
            imageName = "bulb"
            type = "Grass"
            category = "Seed"
            story = "There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger"
        case "Giratina":
            imageName = "gir"
            type = "Dragon, Ghost"
            category = "Renegade"
            story = "This Pokémon is said to live in a world on the reverse side of ours, where common knowledge is distorted and strange"
        default:
            type = "Electric"
            category = "Mouse"
            story = "Pikachu that can generate powerful electricity have cheek sacs that are extra soft and super stretchy"
        }
        
    }
    
    
}
