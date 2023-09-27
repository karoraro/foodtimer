//
//  EggController.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 30/08/2023.
//

import UIKit
import AVFoundation

class EggController: UIViewController {

    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var hardnessLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    
    
    var timer = Timer()
    var timePassed = 0
    var totalTime = -1
    let eggTimes : [String : Int] = ["Light" : 300, "Medium" : 500, "Hard" : 700]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        let step: Float = 1
        let roundedValue = round(sender.value / step) * step
        if roundedValue == 1 {
            UIView.animate(withDuration: 0.1, animations: {
              self.slider.setValue(1, animated:true)
            })
            hardnessLabel.text = "Light"
            progressBar.progress = 0.0
            timeLabel.text = "Time"
        } else if roundedValue == 2 {
            UIView.animate(withDuration: 0.1, animations: {
              self.slider.setValue(2, animated:true)
            })
            hardnessLabel.text = "Medium"
            progressBar.progress = 0.0
            timeLabel.text = "Time"
        } else {
            UIView.animate(withDuration: 0.1, animations: {
              self.slider.setValue(3, animated:true)
            })
            hardnessLabel.text = "Hard"
            progressBar.progress = 0.0
            timeLabel.text = "Time"
        }
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        buttonLabel.setTitle("Reset", for: UIControl.State.normal)
        let chosenEgg = hardnessLabel.text
        
        totalTime = eggTimes[chosenEgg!]!
        timePassed = 0
        progressBar.progress = 0.0
          
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(progressUpdate), userInfo: nil, repeats: true)
        
    }
    
    func animateProgressBar() {
        let percentageProgress = Float(timePassed) / Float(totalTime)
        UIView.animate(withDuration: TimeInterval(0.01)) { self.progressBar.setProgress(percentageProgress, animated: true) }
        
        timePassed += 1
        timeLabel.text = "Time passed: \((timePassed-1)/100) out of: \(totalTime/100)"
    }
    
    @objc func progressUpdate() {
        if timePassed < totalTime {
            animateProgressBar()
        } else {
            animateProgressBar()
            timer.invalidate()
            timeLabel.text = "Ready :)"
            playSound()
            buttonLabel.setTitle("Start Timer", for: UIControl.State.normal)
            }
    }
    
    func playSound() {
        let systemSoundID: SystemSoundID = 1304
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
}

