//
//  InfoViewController.swift
//  Dex
//
//  Created by Hriday Chhabria on 2/26/21.
//

import UIKit
import AVFoundation

class InfoViewController: UIViewController {

    var name = ""
    var currentPoke = Pokemon(name: "")
    var imageName = ""
    var image = UIImage(named: "")
    
    @IBOutlet weak var pokeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var storyLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPoke = Pokemon(name: name)
        
        imageName = currentPoke.imageName
        image = UIImage(named: imageName)
        pokeImage.image = image

        pokeLabel.text = name
        typeLabel.text = "Type: \(currentPoke.type)"
        categoryLabel.text = "Category: \(currentPoke.category)"
        storyLabel.text = currentPoke.story
        
        
        
    
    }
    
    
    @IBAction func speakPressed(_ sender: Any) {
        
        let speachString = "\(currentPoke.name), the \(currentPoke.type) type \(currentPoke.category) pokémon.  \(currentPoke.story)"
        
        let utterance = AVSpeechUtterance(string: speachString)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    


}
