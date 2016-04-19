//
//  EmployeeMethods.swift
//  Handbook
//
//  Created by Алексей Агапов on 19/04/16.
//  Copyright © 2016 ru.urfu. All rights reserved.
//

import Foundation
import KeychainSwift

class UserManipulation {
  
  func mobileCall(phoneNumber:String) {
    defer {
      log.info("mobileCall::end")
    }
    log.info("mobileCall::start")
    UIApplication.sharedApplication().openURL(NSURL(string: "tel://+\(phoneNumber)")!)
  }
}
