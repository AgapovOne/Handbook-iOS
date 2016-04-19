//
//  EmployeeTableViewController.swift
//  Handbook
//
//  Created by Алексей Агапов on 18/04/16.
//  Copyright © 2016 ru.urfu. All rights reserved.
//

import UIKit
import Eureka

class EmployeeTableViewController: FormViewController {
  
  lazy var employee:Employee? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let emp = employee else {return}
    form =
    Section(emp.name!)
    <<< LabelRow() {
      $0.title = "Должность"
      $0.value = emp.job
    }
    <<< LabelRow() {
      $0.title = "Департамент"
      $0.value = emp.department
    }
    <<< LabelRow() {
      $0.title = "Почта"
      $0.value = emp.email
    }
    +++ Section("Телефоны")
    <<< LabelRow() {
      $0.title = "Мобильный"
      $0.value = emp.phoneNumber
    }
    <<< LabelRow() {
      $0.title = "Рабочий телефон"
      $0.value = emp.workNumber
    }
    <<< LabelRow() {
      $0.title = "Остальные телефоны"
      $0.value = emp.additionalNumbers
    }
    <<< ActionSheetRow<String>() {
      $0.title = "Позвонить"
      $0.selectorTitle = "Кому вы хотите позвонить?"
      $0.options = [emp.phoneNumber!, emp.workNumber!]
      $0.value = "Позвонить"
    }
  }
}
