
//
//  EditViewController.swift
//  ACTech
//
//  Created by mac on 9/18/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet fileprivate weak var slider: UISlider! {
        didSet {
            slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        }
    }

    @IBOutlet fileprivate weak var numberField: UITextField! {
        didSet {
            numberField.delegate = self
            numberField.tag = 0
            numberField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    
    @IBOutlet fileprivate weak var ownerField: UITextField! {
        didSet {
            ownerField.delegate = self
            ownerField.tag = 1
            ownerField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    
    @IBOutlet fileprivate weak var cvvField: UITextField! {
        didSet {
            cvvField.delegate = self
            cvvField.tag = 2
            cvvField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    
    @IBOutlet fileprivate weak var activeSwitch: UISwitch! {
        didSet {
            
        }
    }
    
    var setting: ACSetting? {
        didSet {

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let setting = setting else { return }
        
        slider.value = Float(setting.limit ?? 0.6)
        numberField.text = setting.number ?? ""
        ownerField.text = setting.owner ?? ""
        cvvField.text = "\(setting.cvv ?? 544)"
        activeSwitch.isOn = setting.active ?? true
    }
}


extension EditViewController {
    
    @IBAction func didSwitchValue(_ sender: UISwitch) {
        setting?.active = sender.isOn
        
        if let row = ACUser.instance?.settings.firstIndex(where: {$0.id == self.setting?.id}) {
            ACUser.instance?.settings[row] = self.setting!
        }
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                break
            case .moved:
                break
            case .ended:
                setting?.limit = CGFloat(slider.value)
                
                if let row = ACUser.instance?.settings.firstIndex(where: {$0.id == self.setting?.id}) {
                    ACUser.instance?.settings[row] = self.setting!
                }
            default:
                break
            }
        }
    }
}

extension EditViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            setting?.number = textField.text
        case 1:
            setting?.owner = textField.text
        case 2:
            setting?.cvv = Int(textField.text ?? "444")
        default:
            break
        }
   
        if let row = ACUser.instance?.settings.firstIndex(where: {$0.id == self.setting?.id}) {
            ACUser.instance?.settings[row] = self.setting!
        }
    }
}
