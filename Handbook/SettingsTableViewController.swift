//
//  SettingsTableViewController.swift
//  Handbook
//
//  Created by Алексей Агапов on 03/04/16.
//  Copyright © 2016 ru.urfu. All rights reserved.
//

import UIKit
import Eureka
import KeychainSwift

class SettingsTableViewController: FormViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    form =
      Section("Регистрация")
        <<< ButtonRow() {
          $0.title = "Удалить данные обо мне"
          $0.presentationMode = .SegueName(segueName: "SettingsToRegisterSegue", completionCallback:{  vc in vc.dismissViewControllerAnimated(true, completion: nil) })
        }
        .onCellSelection({ (cell, row) in
          KeychainSwift().clear()
        })
      +++
        Section("Информация")
        <<< LabelRow () {
          $0.title = "Ваш телефон"
          $0.value = KeychainSwift().get("phoneNumber")
        }
        <<< LabelRow () {
          $0.title = "Версия"
          $0.value = UIApplication.versionBuild()
        }
  }
}
