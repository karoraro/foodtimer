//
//  PizzaController.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 01/09/2023.
//

import UIKit
import AVFoundation

class PizzaController: UIViewController {
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    var timer = Timer()
    var timePassed = 0
    var totalTime = 500
    
    @IBAction func switchStateChanged(_ sender: UISwitch) {
        if self.switchButton.isOn {
            timeLabel.text = "Time[min]: 10"
            totalTime = 300
        } else {
            timeLabel.text = "Time[min]: 15"
            totalTime = 500
        }
    }
    
    @IBAction func timerButtonPressed(_ sender: UIButton) {
        timerButton.setTitle("Reset", for: UIControl.State.normal)
        
        timePassed = 0
        progressBar.progress = 0.0
          
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(progressUpdate), userInfo: nil, repeats: true)
        
    }
    
    func animateProgressBar() {
        let percentageProgress = Float(timePassed) / Float(totalTime)
        UIView.animate(withDuration: TimeInterval(0.01)) { self.progressBar.setProgress(percentageProgress, animated: true) }
        
        timePassed += 1
    }
    
    @objc func progressUpdate() {
        if timePassed < totalTime {
            animateProgressBar()
        } else {
            animateProgressBar()
            timer.invalidate()
            timeLabel.text = "Ready :)"
            playSound()
            timerButton.setTitle("Start Timer", for: UIControl.State.normal)
            }
    }
    
    func playSound() {
        let systemSoundID: SystemSoundID = 1304
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    
    
}
