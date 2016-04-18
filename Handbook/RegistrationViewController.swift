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
import Alamofire
import SwiftyJSON
import KeychainSwift

class RegistrationViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var textField: PhoneNumberTextField!
  
  @IBOutlet weak var button: UIButton!
  
  lazy var apiUrl:String? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    textField.backgroundColor = globalTintBackground
    textField.layer.cornerRadius = 25.0
    button.layer.cornerRadius = 25.0
    textField.region = "RU"
    textField.delegate = self
    textField.text = "+7"
    textField.becomeFirstResponder()
  }
  
  override func viewDidAppear(animated: Bool) {
    let phone = KeychainSwift().get("phoneNumber")
    if phone != nil {
      apiUrl = KeychainSwift().get("apiUrl")
      self.finishRegistration(phone!)
    } else {
      Digits.sharedInstance().logOut()
      KeychainSwift().set("http://ec2-52-49-236-105.eu-west-1.compute.amazonaws.com:3000", forKey: "apiUrl")
      apiUrl = KeychainSwift().get("apiUrl")
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    register(button)
    return true
  }
  
  @IBAction func register(sender: UIButton) {
    guard let api = KeychainSwift().get("apiUrl") else {return}
    guard let phone = textField.text else {return}
    let urlPhone = urlPhoneNumber(phone)
    
    NetworkManager.sharedInstance.defaultManager.request(.GET, "\(api)/api/v1/reg/check_phone?phoneNumber=\(urlPhone)")
      .validate()
      .responseData { (res) in
        switch res.result {
        case .Failure(let err):
          log.error(err.debugDescription)
        case .Success:
          self.initDigitsController(phone)
        }
    }
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
      if error != nil {
        log.error("Wrong authentication with Digits! \(error)")
      } else {
        log.info("Successful registration, mo'fucka")
        self.finishRegistration(urlPhoneNumber(session.phoneNumber))
      }
    }
  }
  
  func finishRegistration(phoneNumber:String) {
    guard let api = KeychainSwift().get("apiUrl") else {return}
    let urlPhone = urlPhoneNumber(phoneNumber)
    
    NetworkManager.sharedInstance.defaultManager.request(.GET, "\(api)/api/v1/reg/register?phoneNumber=\(urlPhone)")
      .validate()
      .responseJSON { (res) in
        switch res.result {
        case .Failure(let err):
          log.error(err.debugDescription)
        case .Success(let data):
          let json = JSON(data)
          KeychainSwift().set(urlPhone, forKey: "phoneNumber")
          KeychainSwift().set(json["requests"]["employees"].stringValue, forKey: "requests.employees")
          KeychainSwift().set(json["key"].stringValue, forKey: "key")
          
//          self.performSegueWithIdentifier("registerFinishedSegue", sender: nil)
          self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
  }
}
