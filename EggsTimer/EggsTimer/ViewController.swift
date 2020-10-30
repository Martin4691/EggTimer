//
//  ViewController.swift
//  EggsTimer
//
//  Created by Martín on 21/10/2020.
//
import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  let softTime: Int = 300
  let hardTime: Int = 720
  var secondsLeft: Int = 30
  var timer: Timer = Timer()
  var secondsRest: Float = 0
  var player: AVAudioPlayer!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
 
  func playSound(soundName: String) {
    let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
  }

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  @IBAction func stopButton(_ sender: Any) {
    print("STOP!")
    titleLabel.text = "Manda Huevos!"
    timer.invalidate()
    player.stop()
  }
  
  @IBAction func hardnessSelected(_ sender: UIButton) {
    timer.invalidate()
    print("\nSender: \(sender.currentTitle!)")
    let hardness = sender.currentTitle!
    if hardness == "Soft" {
      secondsLeft = softTime
      secondsRest = 0.00333333333333
      print("softTime: \(softTime)")
    } else {
      print("hardTime: \(hardTime)")
      secondsLeft = hardTime
      secondsRest = 0.001388888888889
    }
    
    progressBar.progress = 1.0
    
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
  }
  
  @objc func updateTimer() {
    //example functionality
    
    if secondsLeft > 0 {
      titleLabel.text = "Cocinando Espere..."
      print("\(secondsLeft) seconds to finish")
      secondsLeft -= 1
      progressBar.progress = progressBar.progress - secondsRest
      print("percentageProgress: \(progressBar.progress)")
    }
    if secondsLeft <= 0 {
      titleLabel.text = "Cocción Finalizada!"
      timer.invalidate()
      playSound(soundName: "alarm")
    }
  }
}




