//
//  AlamofireConfig.swift
//  Handbook
//
//  Created by Алексей Агапов on 13/04/16.
//  Copyright © 2016 ru.urfu. All rights reserved.
//

import Alamofire

class NetworkManager {
  static let sharedInstance = NetworkManager()
  
  let defaultManager: Alamofire.Manager = {
    let serverTrustPolicies: [String: ServerTrustPolicy] = [
      "ec2-52-49-236-105.eu-west-1.compute.amazonaws.com": .DisableEvaluation
    ]
    
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 10
    
    return Alamofire.Manager(
      configuration: configuration,
      serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
    )
  }()
  
//  func error(err:NSError, res: Response<NSData,NSError>) {
//    /*Log.error?.message("Error: \(err)")
//     Log.debug?.message("Request: \(res.request)")
//     Log.debug?.message("Response: \(res.response)")*/
//    Log.debug?.message("Description: \(res.debugDescription)")
//  }
//  
//  func error(err:NSError, res: Response<String,NSError>) {
//    /*Log.error?.message("Error: \(err)")
//     Log.debug?.message("Request: \(res.request)")
//     Log.debug?.message("Response: \(res.response)")*/
//    Log.debug?.message("Description: \(res.debugDescription)")
//  }
//  
//  func error(err:NSError, res: Response<AnyObject,NSError>) {
//    /*Log.error?.message("Error: \(err)")
//     Log.debug?.message("Request: \(res.request)")
//     Log.debug?.message("Response: \(res.response)")*/
//    Log.debug?.message("Description: \(res.debugDescription)")
//  }
}