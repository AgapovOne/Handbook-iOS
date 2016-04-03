//
//  RegistrationViewController.swift
//  Handbook
//
//  Created by Алексей Агапов on 03/04/16.
//  Copyright © 2016 ru.urfu. All rights reserved.
//

import UIKit
import PhoneNumberKit
import DigitsKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var textField: PhoneNumberTextField!
  
  @IBOutlet weak var button: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    textField.layer.borderWidth = 0
    textField.backgroundColor = globalTintBackground
    textField.layer.cornerRadius = 25.0
    button.layer.cornerRadius = 25.0
    textField.delegate = self
    textField.becomeFirstResponder()
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    register(button)
    return true
  }
  
  @IBAction func register(sender: UIButton) {
    guard let phone = textField.text else {return}
    initDigitsController(phone)
  }
  
  func animateLoadingButton(button:UIButton) {
  }
  
  func initDigitsController(phoneNumber:String) {
    let digits = Digits.sharedInstance()
    let configuration = DGTAuthenticationConfiguration(accountFields: .DefaultOptionMask)
    let appearance = DGTAppearance()
    appearance.backgroundColor = globalTintBackground
    appearance.accentColor = globalTint
    appearance.bodyFont = UIFont.systemFontOfSize(16.0, weight: UIFontWeightLight)
    configuration.appearance = appearance
    
    configuration.phoneNumber = phoneNumber
    
    digits.authenticateWithViewController(nil, configuration: configuration) { session, error in
      
    }
  }
}
