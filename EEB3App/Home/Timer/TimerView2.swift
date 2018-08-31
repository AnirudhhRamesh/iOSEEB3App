//
//  TimerViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 15/08/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class TimerView2: UIViewController {
    
    
    @IBOutlet weak var resetButtonOutlet: UIButton!
    @IBOutlet weak var stopButtonOutlet: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var time: UILabel!
    
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    var resumeTapped = false
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerView.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        stopButtonOutlet.isEnabled = true
    }
    
    func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate "time's up!"
        } else {
            seconds -= 1
            time.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @IBAction func startButton2(_ sender: Any) {
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
            stopButtonOutlet.isEnabled = true
            resetButtonOutlet.isEnabled = true
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.stopButtonOutlet.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            self.stopButtonOutlet.setTitle("Pause",for: .normal)
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        seconds = 60
        time.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        stopButtonOutlet.isEnabled = false
        stopButtonOutlet.setTitle("Pause", for: .normal)
        startButton.isEnabled = true
        resetButtonOutlet.isEnabled = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButtonOutlet.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
