//
//  HomeViewController.swift
//  SectionMatt
//
//  Created by Rohan Nagesh on 6/2/18.
//  Copyright © 2018 Rohan Nagesh. All rights reserved.
//

import UIKit
import GameKit

class HomeViewController: UIViewController {

   
    @IBOutlet weak var upperBodyButton: UIButton!
    @IBOutlet weak var lowerBodyButton: UIButton!
    @IBOutlet weak var absButton: UIButton!
    @IBOutlet weak var customWorkoutButton: UIButton!
    
    let lowerBodyExercises = ["air squats", "mountain climbers", "jump squats", "lunges", "jumping lunges", "burpees", "sumo squats", "side lunges", "reverse lunges", "clam shells"]
    
    let upperBodyExercises = ["push-ups", "wide pushups", "diamond pushups", "burpees", "bench dips"]
    
    let coreExercises = ["sit-ups", "straight leg sit-ups", "toe-taps", "v-ups", "ab bikes", "leg raises", "suitcases"]
    
    var workout = [String]()
    
    @IBAction func workoutSelected(_ sender: UIButton) {
        switch sender.currentTitle! {
        case upperBodyButton.currentTitle!:
            
            let shuffledExercises = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: upperBodyExercises) as! [String]
            
            for exercise in shuffledExercises.prefix(4) {
                workout.append(exercise)
            }
            self.performSegue(withIdentifier: "homeToStart", sender: self)
            break
        case lowerBodyButton.currentTitle!:
            let shuffledExercises = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lowerBodyExercises) as! [String]
            
            for exercise in shuffledExercises.prefix(4) {
                workout.append(exercise)
            }
            self.performSegue(withIdentifier: "homeToStart", sender: self)
            break
        case absButton.currentTitle!:
            let shuffledExercises = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: coreExercises) as! [String]
            
            for exercise in shuffledExercises.prefix(4) {
                workout.append(exercise)
            }
            self.performSegue(withIdentifier: "homeToStart", sender: self)
            break
        case customWorkoutButton.currentTitle!:
            self.performSegue(withIdentifier: "customWorkout", sender: self)
            break
        default:
            break
        }
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workout.removeAll()
        // Do any additional setup after loading the view.
        
        let attrs = [
            NSForegroundColorAttributeName: UIColor.white,
            
            NSFontAttributeName: UIFont(name: "Billabong", size: 35)!
        ]
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.68, blue:0.94, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = attrs
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        workout.removeAll()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            if identifier == "homeToStart" {
                if let destVC = segue.destination as? ExerciseViewController {
                    destVC.exerciseOne = workout[0]
                    destVC.exerciseTwo = workout[1]
                    destVC.exerciseThree = workout[2]
                    destVC.exerciseFour = workout[3]
                }
            }
        }
    }
}



