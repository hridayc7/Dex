//
//  ViewController.swift
//  Dex
//
//  Created by Hriday Chhabria on 2/25/21.
//

import UIKit
import CoreML
import Vision
import ImageIO
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var pokeBall: UIImageView!
    @IBOutlet weak var pokeLabel: UILabel!
    @IBOutlet weak var speakInfoButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var learnMore: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        learnMore.isHidden = true
        speakInfoButton.isHidden = true
        //pokeLabel.text = ""
    }
    
    
        
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        print("Button Tapped")
                
        pokeBall.rotate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            
            let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(actionSheet, animated: true, completion: nil)
        }
                
                
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let userPickedImage = info[.originalImage] as? UIImage{
                imageView.image = userPickedImage
                guard let ciimage = CIImage(image: userPickedImage) else{
                    fatalError("Failed to convert image")
                }
                detect(image: ciimage)
            }
            
        infoLabel.isHidden = true
            picker.dismiss(animated: true, completion: nil)
        }
    
    func detect(image: CIImage){
      
         guard let model = try? VNCoreMLModel(for:  Pok().model) else{
             fatalError("Loading coreMl Model failure")
         }
         
         let request = VNCoreMLRequest(model: model) { (request, error) in
             guard let results = request.results as? [VNClassificationObservation] else {
                 fatalError("Model Failed to process image")
             }
             //MARK:- Perfom All Result to label modification here
             print(results)
             let itemName = results.first?.identifier
             print(itemName)
            self.learnMore.isHidden = false
            self.speakInfoButton.isHidden = false
            self.pokeLabel.text = itemName!
             
             //MARK: - GET TEXT -> PASS IN STATIC FUNCTION (STORE THE NAME OF THE CURRENT FOOD ITEM THERE) -> SEGUE TO THE PLACE CHANGE STATIC FUNCTION BOOLEAN VALUE -> WHEN THAT APPEARS -> HAVE A CHECK ON THE VIEW DID LOAD TO SEE WHETHER PREVIOUS SCREEN WAS STATIC FUNCTION OR NOT -> IF IT WAS -> MAKE THE STATIC VARIABLE FALSE -> FILL ALL THE TEXT FIELDS WITH THE STATIC FUNCTION VALUES THAT CORRESPOND
             
         }
        
         let handler = VNImageRequestHandler(ciImage: image)
         do
         {
             try handler.perform([request])
         }
         catch
         {
             print(error)
         }
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let poke = self.pokeLabel.text!
        
        guard let destinationVC = segue.destination as? InfoViewController else { return }
        destinationVC.name = poke
    }
    
    @IBAction func speakInfo(_ sender: Any) {
        let currentPoke = Pokemon(name: self.pokeLabel.text!)
        
        let speachString = "\(currentPoke.name), the \(currentPoke.type) type \(currentPoke.category) pokémon.  \(currentPoke.story)"
        
        let utterance = AVSpeechUtterance(string: speachString)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        
    }
    
    


}

