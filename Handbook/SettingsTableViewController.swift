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
    
    form =
      Section("Регистрация")
        <<< ButtonRow() {
          $0.title = "Пройти регистрацию"
          $0.presentationMode = .SegueName(segueName: "SettingsToRegisterSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
        }
      +++ Section("Информация")
//        <<< LabelRow () {
//          $0.title = "Организация"
//          $0.value = "УрФУ"
//        }
        <<< LabelRow () {
          $0.title = "Версия"
          $0.value = UIApplication.versionBuild()
        }
  }
}
