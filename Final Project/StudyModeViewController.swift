//
//  StudyModeViewController.swift
//  Final Project
//
//  Created by 张泽华 on 2020/4/20.
//  Copyright © 2020 张泽华. All rights reserved.
//

import UIKit
import UserNotifications

class StudyModeViewController: UIViewController {

    @IBOutlet weak var studyModeSwitch: UISwitch!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    //var datePicker: UIDatePicker?
    var timer = Timer()
    var isTimerRunning = false
    var seconds = 1800
    var count = 0
    let center = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound];

    override func viewDidLoad() {
        super.viewDidLoad()
        notif()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowGame"{
            let destination = segue.destination as! ViewController
        }
        else if segue.identifier == "ShowDictionary"{
            let destination = segue.destination as! dictionaryViewController
        }
        else if segue.identifier == "ShowMap"{
            let destination = segue.destination as! MapViewController
        }
       
    }
    
    func notif(){
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                
            }
        }
        
        let content = UNMutableNotificationContent()
        if count > 3{
            count*=30
            content.title = "You will be rewarded by your hard working!"
            content.body = "You studied \(count) minutes today"
            content.sound = UNNotificationSound.default
        }
        else{
            count*=30
            content.title = "You need to work harder!"
            content.body = "You studied \(count) minutes today"
            content.sound = UNNotificationSound.default
        }
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 22
        dateComponents.minute = 34
 
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        })

    }
    
    func runTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(StudyModeViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let hour = "\(hours):\(minutes):\(seconds)"
        return hour
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            count += 1
            startButton.isEnabled = true
            seconds = 1800
            timeLabel.text = timeString(time: TimeInterval(seconds))
        } else {
             seconds -= 1
             timeLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            startButton.isEnabled = false
         }
    }

    
    
   

}
