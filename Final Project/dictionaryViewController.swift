//
//  dictionaryViewController.swift
//  Final Project
//
//  Created by 张泽华 on 2020/4/21.
//  Copyright © 2020 张泽华. All rights reserved.
//

import UIKit

class dictionaryViewController: UIViewController {
    @IBOutlet weak var wordSearched: UITextField!
    @IBOutlet weak var answerTextView: UITextView!
    var API = SwiftOxfordAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func search(_ sender: UIButton) {
        API.word = wordSearched.text ?? "unknown"
        API.getData()
    }
    
    

    

}
