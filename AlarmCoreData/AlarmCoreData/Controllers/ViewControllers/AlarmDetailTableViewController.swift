//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Andrew Saeyang on 7/29/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    // MARK: - PROPERTIES
    
    var isAlarmOn: Bool = true
    var alarm: Alarm?
    
    
    
    
    
    // MARK: - OUTLETS
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabledButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }

    
    
    // MARK: - ACTIONS
    @IBAction func alarmIsEnabledButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
            isAlarmOn = alarm.isEnabled
        }else{
            isAlarmOn.toggle()
        }
        designIsEnabledButton()
        
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitleTextField.text, !title.isEmpty else { return }
        
        if let alarm = alarm{
            AlarmController.shared.update(alarm: alarm, newTitle: title, newFireDate: alarmFireDatePicker.date, isEnabled: isAlarmOn)
        }else{
            AlarmController.shared.createAlarm(withTitle: title, on: alarmIsEnabledButton.isEnabled, and: alarmFireDatePicker.date)
        }
              
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - HELPER METHODS
    func updateViews(){
        guard let alarm = alarm else { return }
        
        alarmFireDatePicker.date = alarm.fireDate ?? Date()
        alarmTitleTextField.text = alarm.title
        isAlarmOn = alarm.isEnabled
        designIsEnabledButton()
        
        
    }
    func designIsEnabledButton() {
        
            switch isAlarmOn {
            case true:
                alarmIsEnabledButton.backgroundColor = .white
                alarmIsEnabledButton.setTitle("Enabled", for: .normal)
            case false:
                alarmIsEnabledButton.backgroundColor = .darkGray
                alarmIsEnabledButton.setTitle("Disabled", for: .normal)
            }
        }
    
}
