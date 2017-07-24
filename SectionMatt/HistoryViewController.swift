//
//  HistoryViewController.swift
//  SectionMatt
//
//  Created by Rohan Nagesh on 7/3/17.
//  Copyright © 2017 Rohan Nagesh. All rights reserved.
//

import UIKit
import Parse

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var historyTable: UITableView!
    
    var workouts = [Workout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTable.delegate = self
        historyTable.dataSource = self
        historyTable.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Fetch workout history from Parse
        let currentDevice = UIDevice.current.identifierForVendor!.uuidString
        
        let query = PFQuery(className: "Workout")
        query.whereKey("device_id", equalTo: currentDevice)
        query.order(byDescending: "date")
        
        
        //Render loading spinner
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        //Perform Query
        query.findObjectsInBackground { (objects, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            guard error == nil else {
                print("Error fetching history for user")
                return
            }
            
            print("Successfully fetched history for user")
            if objects != nil {
                for object in objects! {
                    let date = object["date"] as! String
                    let completionTime = object["completionTime"] as! String
                    let exerciseList = object["exerciseList"] as! String
                    
                    
                    let workout = Workout(date: date, completionTime: completionTime, exerciseList: exerciseList)
                    self.workouts.append(workout)
                    self.historyTable.reloadData()
                }
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table View DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        historyTable.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as! HistoryTableViewCell
        
        let workout = workouts[indexPath.row]
        cell.date.text = workout.date
        cell.completionTime.text = workout.completionTime
        cell.exerciseList.text = workout.exerciseList
        
        return cell
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
