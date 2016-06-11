//
//  AppDelegate.swift
//  Handbook
//
//  Created by Алексей Агапов on 02/04/16.
//  Copyright © 2016 ru.urfu. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import DigitsKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    self.makeView()
    
    Fabric.with([Crashlytics.self, Digits.self])
    return true
  }

  //MARK: - Custom methods
  func makeView() {
    let navigationBarAppearance = UINavigationBar.appearance()
    navigationBarAppearance.barTintColor = mainColor
    navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName:UIFont.systemFontOfSize(18, weight: UIFontWeightMedium)]
    navigationBarAppearance.tintColor = UIColor.whiteColor()
    
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = mainColor
    let tabBarItemAppearance = UITabBarItem.appearance()
    tabBarItemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName:mainColor], forState: UIControlState.Selected)
    
    tabBarItemAppearance.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(10, weight: UIFontWeightLight)], forState: UIControlState.Normal)
  }
}

