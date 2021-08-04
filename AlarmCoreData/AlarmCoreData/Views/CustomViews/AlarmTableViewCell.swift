//
//  AlarmTableViewCellTableViewCell.swift
//  AlarmCoreData
//
//  Created by Andrew Saeyang on 7/29/21.
//

import UIKit

protocol AlarmTableViewCellDelegate: AnyObject {
    func alarmWasToggled(sender: AlarmTableViewCell)
    
}

class AlarmTableViewCell: UITableViewCell {

    // MARK: - PROPERTIES
    
    weak var delegate: AlarmTableViewCellDelegate?
    
    // MARK: - OUTLETS
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    
    // MARK: - HELPER METHODS
   func updateViews(alarm: Alarm){
        alarmTitleLabel.text = alarm.title
        alarmFireDateLabel.text = alarm.fireDate!.dateAsString() //force unwrap because alarm cannot initalize without one
    isEnabledSwitch.isOn = alarm.isEnabled
        
    }
    
    // MARK: - ACTIONS
    @IBAction func isEnabledSwitchToggled(_ sender: Any) {
        delegate?.alarmWasToggled(sender: self)
    }
    

}
