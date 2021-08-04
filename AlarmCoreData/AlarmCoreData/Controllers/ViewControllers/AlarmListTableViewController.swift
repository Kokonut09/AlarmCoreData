//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by Andrew Saeyang on 7/29/21.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlarmController.shared.fetchAlarmss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? AlarmTableViewCell else { return UITableViewCell()}
        
        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        cell.updateViews(alarm: alarm)
        
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            
            let alarmToDelete = AlarmController.shared.alarms[indexPath.row]
            
            AlarmController.shared.delete(alarm: alarmToDelete)
            
          
            tableView.deleteRows(at: [indexPath], with: .fade)
     
        }
    }

    // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Identifier
        if segue.identifier == "toDetailTV"{
            
            //IndexPath
            //Destination
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? AlarmDetailTableViewController else { return }
                
            //Object to Send
            
            let alarm = AlarmController.shared.alarms[indexPath.row]
            
            //Object to Reciever
            destination.alarm = alarm
            
        }
     }
}

extension AlarmListTableViewController: AlarmTableViewCellDelegate {
    func alarmWasToggled(sender: AlarmTableViewCell){
        
        guard let indexPath = tableView.indexPath(for: sender) else { return }
     
        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
        
        sender.updateViews(alarm: alarm)
        
        
    }
}
