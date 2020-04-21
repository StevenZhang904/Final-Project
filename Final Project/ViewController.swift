//
//  ViewController.swift
//  Final Project
//
//  Created by 张泽华 on 2020/4/19.
//  Copyright © 2020 张泽华. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
        var count = 0
        var arrayOne: [Int] = []
        var arrayTwo: [Int] = []
        var arrayThree: [Int] = []
        let emojiArray = ["🐶","🐱","🐭","🐰","🐼","🐷","🐵","🦄","🐔","🐮"]
        
        @IBOutlet weak var textLabel: UILabel!
        @IBOutlet weak var emojiPickerView: UIPickerView!
        @IBOutlet weak var goButton: UIButton!
    
        @IBAction func goButtonPressed(_ sender: UIButton) {
                self.emojiPickerView.selectRow(Int(arrayOne[(Int.random(in: 0...99))]), inComponent: 0, animated: true)
                self.emojiPickerView.selectRow(Int(arrayTwo[(Int.random(in: 0...99))]), inComponent: 1, animated: true)
                self.emojiPickerView.selectRow(Int(arrayThree[(Int.random(in: 0...99))]), inComponent: 2, animated: true)
                count += 1
            if count <= 10{
                if arrayOne[self.emojiPickerView.selectedRow(inComponent: 0)] == arrayTwo[self.emojiPickerView.selectedRow(inComponent: 1)] || arrayTwo[self.emojiPickerView.selectedRow(inComponent: 1)] == arrayThree[self.emojiPickerView.selectedRow(inComponent: 2)] {
                    textLabel.text = "You earned yourself a 2 minutues rest!"
                    //print("\(time.restTime)")
                    //time.restTime += 2
                    UIView.animate(withDuration: 0.2, animations: {
                        self.goButton.backgroundColor = UIColor.clear
                    })
                } else {
                    textLabel.text = "Try it!"
                    UIView.animate(withDuration: 0.3, animations: {
                        self.goButton.backgroundColor = UIColor.clear
                    })
                }
            }
            else{
                textLabel.text = "You have tried too many times. Back to Work!"
                goButton.isEnabled = false
            }
        }
    
        //var time: Time!
        
    
        override func viewDidLoad() {
            super.viewDidLoad()
            print("a")
            emojiPickerView.delegate = self
            emojiPickerView.dataSource = self
            emojiPickerView.isUserInteractionEnabled = false
    
            for _ in 0..<100 {
                arrayOne.append(Int.random(in: 0...9))
                arrayTwo.append(Int.random(in: 0...9))
                arrayThree.append(Int.random(in: 0...9))
            }
        }

//        @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
//            let isPresentingInAddMode = presentingViewController is UINavigationController
//            if isPresentingInAddMode{
//                dismiss(animated: true, completion: nil)
//            }
//        }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
        


        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 3
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return 100
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return 100
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 100
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let pickerLabel = UILabel()
            pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 70)
            pickerLabel.textAlignment = .center
            switch component {
            case 0:
                pickerLabel.text = emojiArray[Int(arrayOne[row])]
            case 1:
                pickerLabel.text = emojiArray[Int(arrayTwo[row])]
            case 2:
                pickerLabel.text = emojiArray[Int(arrayThree[row])]
            default:
                break
            }
            return pickerLabel
        }
        
}




