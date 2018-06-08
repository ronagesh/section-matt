//
//  StartViewController.swift
//  SectionMatt
//
//  Created by Rohan Nagesh on 6/10/17.
//  Copyright © 2017 Rohan Nagesh. All rights reserved.
//

import UIKit
import Parse

class StartViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var exerciseOne: UITextField!
    @IBOutlet weak var exerciseTwo: UITextField!
    @IBOutlet weak var exerciseThree: UITextField!
    @IBOutlet weak var exerciseFour: UITextField!
    
    @IBAction func startWorkoutPressed() {
        self.performSegue(withIdentifier: "startToExercise", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseOne.delegate = self
        exerciseTwo.delegate = self
        exerciseThree.delegate = self
        exerciseFour.delegate = self
        
        let attrs = [
            NSForegroundColorAttributeName: UIColor.white,
            
            NSFontAttributeName: UIFont(name: "Billabong", size: 35)!
        ]
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.68, blue:0.94, alpha:1.0)
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        
        /*for family in UIFont.familyNames
        {
            print("Family: \(family)")
            
            for name in UIFont.fontNames(forFamilyName: family)
            {
                print("Name: \(name)")
            }
        }*/

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if let identifier = segue.identifier {
            if identifier == "startToExercise" {
                if let destVC = segue.destination as? ExerciseViewController {
                    destVC.exerciseOne = exerciseOne.text
                    destVC.exerciseTwo = exerciseTwo.text
                    destVC.exerciseThree = exerciseThree.text
                    destVC.exerciseFour = exerciseFour.text
                }
            }
        }
        
    }
    

}
