//
//  ExerciseViewController.swift
//  SectionMatt
//
//  Created by Rohan Nagesh on 6/10/17.
//  Copyright © 2017 Rohan Nagesh. All rights reserved.
//

import UIKit
import Parse

class ExerciseViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var currentExercise: UILabel!
    @IBOutlet weak var numCardsRemaining: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var stopwatch: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    
    // MARK: Properties
    var exerciseOne: String?
    var exerciseTwo: String?
    var exerciseThree: String?
    var exerciseFour: String?
   
    // MARK: Model
    var completed = [Int]()
    let DECK_SIZE = 52
    var timer = Timer()
    var startTime = 0.0
    var elapsedTime = 0.0
    var isPaused = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTime = Date().timeIntervalSinceReferenceDate
        runTimer()
        setupDeck()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateStopwatch), userInfo: nil, repeats: true)
    }
    
    func setupDeck() {
        let firstIndex = Int(arc4random_uniform(UInt32(DECK_SIZE)))
        currentExercise.text = exerciseFromIndex(index: firstIndex)
        numCardsRemaining.text = String(DECK_SIZE - completed.count) + " Exercises Remaining"
        completed.append(firstIndex)
    }
    
    //Input: index into virtual array representing deck of cards
    //Output: string representing exercise to be performed
    
    func exerciseFromIndex(index: Int) -> String {
        let repCount = (index % 13) + 2

        switch index {
        case 0..<13:
            return String(repCount) + " " + exerciseOne!
        case 13..<26:
            return String(repCount) + " " + exerciseTwo!
        case 26..<39:
            return String(repCount) + " " + exerciseThree!
        default:
            return String(repCount) + " " + exerciseFour!
        }
    }


    @IBAction func pausePressed() {
        if (!isPaused) {
            timer.invalidate()
            pauseButton.setTitle("Resume", for: UIControlState.normal)
            isPaused = true
            nextButton.isEnabled = false
        } else {
            startTime = Date().timeIntervalSinceReferenceDate - elapsedTime
            runTimer()
            pauseButton.setTitle("Pause", for: UIControlState.normal)
            isPaused = false
            nextButton.isEnabled = true

        }
    }
    @IBAction func nextPressed() {
        if completed.count == DECK_SIZE {
            currentExercise.text = "Workout Complete!"
            nextButton.isEnabled = false
            numCardsRemaining.text = ""
            
            let workout = PFObject(className: "Workout")
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-DD-YYYY"
            let formattedDate = formatter.string(from: date)
            workout["device_id"] = UIDevice.current.identifierForVendor!.uuidString
            workout["date"] = formattedDate
            workout["completionTime"] = stopwatch.text
            workout["exerciseList"] = exerciseOne! + ", " +  exerciseTwo! + ", "  + exerciseThree! + ", "  + exerciseFour!
            workout.saveInBackground(block: { (success, error) in
                if success {
                    print("Successfully saved workout to Parse")
                } else {
                    print("Error saving workout to Parse")
                }
            })
            
            timer.invalidate()
            
            
            return
        }
        
        var nextIndex = Int(arc4random_uniform(52))
        while (completed.contains(nextIndex)) {
            nextIndex = Int(arc4random_uniform(52))
        }
        currentExercise.text = exerciseFromIndex(index: nextIndex)
        let cardsRemaining = DECK_SIZE - completed.count
        if cardsRemaining == 1 {
            nextButton.setTitle("Finish", for: UIControlState.normal)
            numCardsRemaining.text = String(cardsRemaining) + " Exercise Remaining"
        } else {
            numCardsRemaining.text = String(cardsRemaining) + " Exercises Remaining"
        }
        completed.append(nextIndex)
    }
    
    func updateStopwatch() {
        elapsedTime += 1
        var timeSince = Date.timeIntervalSinceReferenceDate - startTime
        
        let hours = Int(timeSince / 3600)
        timeSince -= TimeInterval(hours * 3600)
        
        let mins = Int(timeSince / 60)
        timeSince -= TimeInterval(mins * 60)
        
        let secs = Int(timeSince)
        
        let strHours = String(format: "%02d", hours)
        let strMins = String(format: "%02d", mins)
        let strSecs = String(format: "%02d", secs)
        
        stopwatch.text = strHours + ":" + strMins + ":" + strSecs
    }
}
