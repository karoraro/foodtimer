//
//  CustomController.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 25/09/2023.
//

import UIKit
import AudioToolbox

class CustomController: UIViewController, UIPickerViewDataSource,  UIPickerViewDelegate {
    
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var timer = Timer()
    var totalTimeInSeconds: Int = 0
    var isTimerRunning = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.delegate = self
        timePicker.dataSource = self
    }
    
    func numberOfComponents(in timePicker: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ timePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24 + 1
        case 1:
            return 60
        case 2:
            return 60
        default:
            return 0 // Return 0 for unknown components
        }
    }
    
    func pickerView(_ timePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        case 2:
            return "\(row)"
        default:
            return nil
        }
    }
    
    func pickerView(_ timePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let selectedRow = row
//        let selectedComponent = component
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        if isTimerRunning {
            // Timer is running, pause it
            timer.invalidate()
            startButton.setTitle("Start", for: .normal)
            startButton.layer.cornerRadius = 10
        } else {
            // Timer is not running, start it or resume it
            if totalTimeInSeconds > 0 {
                // Timer hasn't reached 0, resume it
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timePassing), userInfo: nil, repeats: true)
                startButton.setTitle("Pause", for: .normal)

            } else {
                // Timer has reached 0, restart it
                let selectedHours = timePicker.selectedRow(inComponent: 0)
                let selectedMinutes = timePicker.selectedRow(inComponent: 1)
                let selectedSeconds = timePicker.selectedRow(inComponent: 2)
                
                totalTimeInSeconds = (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
                
                // Start the countdown timer
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timePassing), userInfo: nil, repeats: true)
                
                // Update the button title
                startButton.setTitle("Pause", for: .normal)

            }
        }
        isTimerRunning.toggle() // Toggle the timer state
    }
    
    @objc func timePassing() {
        // Decrement remaining time
            totalTimeInSeconds -= 1
            
            // Update UIPickerView to reflect remaining time
            let hours = totalTimeInSeconds / 3600
            let minutes = (totalTimeInSeconds % 3600) / 60
            let seconds = totalTimeInSeconds % 60
            
            timePicker.selectRow(hours, inComponent: 0, animated: true)
            timePicker.selectRow(minutes, inComponent: 1, animated: true)
            timePicker.selectRow(seconds, inComponent: 2, animated: true)
            
            // Check if the timer has reached 0
            if totalTimeInSeconds <= 0 {
                // Invalidate the timer
                timer.invalidate()
                
                // Reset the button title
                startButton.setTitle("Start", for: .normal)
                playSound()
            }
        }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        startButton.setTitle("Start", for: .normal)
        
        // Reset the UIPickerView values to 0
        timePicker.selectRow(0, inComponent: 0, animated: true)
        timePicker.selectRow(0, inComponent: 1, animated: true)
        timePicker.selectRow(0, inComponent: 2, animated: true)
        
        // Update your totalTimeInSeconds variable if needed
        totalTimeInSeconds = 0
    }
    
    func playSound() {
        let systemSoundID: SystemSoundID = 1304
        AudioServicesPlaySystemSound(systemSoundID)
    }
        
}
