//
//  Time.swift
//  Final Project
//
//  Created by 张泽华 on 2020/4/19.
//  Copyright © 2020 张泽华. All rights reserved.
//

import Foundation

class Time{
    
    var restTime: Int
    var studyTime: Int

    init(restTime: Int, studyTime: Int) {
        self.restTime = restTime
        self.studyTime = studyTime
    }
    
    convenience init() {
        self.init(restTime: 0, studyTime: 0 )
    }
    
}
