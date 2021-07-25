//
//  ViewController.swift
//  EXIBActionHW
//
//  Created by Mac on 2021/7/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tolkTextField: UITextField!
    
    @IBOutlet weak var intonationSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var intonationLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
    @IBOutlet weak var languageSegmented: UISegmentedControl!
    
    var languageTemp:String? = "zh_TW"
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        volumeLabel.text = String(Int(volumeSlider.value*100))
        speedLabel.text = String(Int(speedSlider.value*100))
        intonationLabel.text = String(Int(intonationSlider.value*100))
        
    }

    @IBAction func clearTolkButton(_ sender: Any) {
        tolkTextField.text = nil
    }
    @IBAction func dissmisskeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func LanguageSegmentChange(_ sender: Any) {
        if languageSegmented.selectedSegmentIndex == 0 {
            languageTemp = "zh_TW"
        } else if languageSegmented.selectedSegmentIndex == 1 {
            languageTemp = "en-gb"
        } else if languageSegmented.selectedSegmentIndex == 2 {
            languageTemp = "ja-jp"
        }
    }
    @IBAction func ChangeSlider(_ sender: UISlider) {
        if sender.tag == 1 {
            volumeLabel.text = String(Int(volumeSlider.value*100))
        } else if sender.tag == 2 {
            speedLabel.text = String(Int(speedSlider.value*100))
        } else if sender.tag == 3 {
            intonationLabel.text = String(Int(intonationSlider.value*100))
        }
    }
    
    @IBAction func speak(_ sender: UIButton) {
        
        // Create an utterance.
        let utterance = AVSpeechUtterance(string: tolkTextField.text!)
        // Configure the utterance.
        utterance.postUtteranceDelay = 1
        utterance.rate = speedSlider.value
        utterance.pitchMultiplier = intonationSlider.value
        utterance.volume = volumeSlider.value
        // Retrieve the British English voice.
        let voice = AVSpeechSynthesisVoice(language: languageTemp)
        // Assign the voice to the utterance.
        utterance.voice = voice
        // Tell the synthesizer to speak the utterance.
//        synthesizer.speak(utterance)
        
        if sender.titleLabel?.text == "請讓我說" {
            synthesizer.speak(utterance)
        } else if sender.titleLabel?.text == "暫停一下" {
            synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
        } else if sender.titleLabel?.text == "我想繼續聽" {
            synthesizer.continueSpeaking()
        } else if sender.titleLabel?.text == "先停一下" {
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
        
        
//        print("sender",sender.titleLabel?.text)
    }
}

