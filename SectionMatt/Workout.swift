//
//  Workout.swift
//  SectionMatt
//
//  Created by Rohan Nagesh on 7/3/17.
//  Copyright © 2017 Rohan Nagesh. All rights reserved.
//

import Foundation

class Workout {
    var date: String
    var completionTime: String
    var exerciseList: String
    
    init(date: String, completionTime: String, exerciseList: String) {
        
        self.date = date
        self.completionTime = completionTime
        self.exerciseList = exerciseList
    
    }
    
}
