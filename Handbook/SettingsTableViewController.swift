//
//  SettingsTableViewController.swift
//  Handbook
//
//  Created by Алексей Агапов on 03/04/16.
//  Copyright © 2016 ru.urfu. All rights reserved.
//

import UIKit
import Eureka

class SettingsTableViewController: FormViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    form +++=
      Section("Информация")
        <<< LabelRow () {
          $0.title = "Организация"
          $0.value = "УрФУ"
        }
        <<< SwitchRow() {
          $0.title = "Супер приложение"
          $0.value = true
        }
        <<< ButtonRow() {
          $0.title = "Зарегистрироваться"
          $0.presentationMode = .SegueName(segueName: "SettingsToRegisterSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
        }
  }
}
