//
//  HandbookTableViewController.swift
//  Handbook
//
//  Created by Алексей Агапов on 03/04/16.
//  Copyright © 2016 ru.urfu. All rights reserved.
//

import UIKit
import KeychainSwift
import SwiftyJSON
import DGElasticPullToRefresh
import Dollar

class HandbookTableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
  
  lazy var employees: [Employee]? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let phone = KeychainSwift().get("apiUrl")
    if (phone == nil) {
      self.performSegueWithIdentifier("initialRegistrationSegue", sender: nil)
    } else {
      // Initialize tableView
      let loadingView = DGElasticPullToRefreshLoadingViewCircle()
      loadingView.tintColor = globalTint
      tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
        
        self?.loadData((self?.tableView)!)
        // Do not forget to call dg_stopLoading() at the end
        self?.tableView.dg_stopLoading()
        }, loadingView: loadingView)
      tableView.dg_setPullToRefreshFillColor(globalTintBackground)
      tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
      
      tableView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
      tableView.dataSource = self
      tableView.delegate = self
      tableView.emptyDataSetSource = self
      tableView.emptyDataSetDelegate = self
      tableView.tableFooterView = UIView()
      
      tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  deinit {
    tableView.dg_removePullToRefresh()
  }
  
  func loadData(tableView:UITableView) -> Bool {
    guard let api = KeychainSwift().get("apiUrl") else {return false}
    guard let employees = KeychainSwift().get("requests.employees") else {return false}
    guard let phone = KeychainSwift().get("phoneNumber") else {return false}
    guard let key = KeychainSwift().get("key") else {return false}
    let urlPhone = urlPhoneNumber(phone)
    
    NetworkManager.sharedInstance.defaultManager.request(.GET, "\(api)\(employees)?phoneNumber=\(urlPhone)&key=\(key)")
      .validate()
      .responseJSON { (res) in
        switch res.result {
        case .Failure(let err):
          log.error(err.debugDescription)
          tableView.dg_stopLoading()
        case .Success(let data):
          let json = JSON(data)
          guard let array = json.array else {tableView.dg_stopLoading();return}
          $.each(array) { (index, item) in
            let employee = Employee(
              name: item["name"].string,
              phoneNumber: item["phoneNumber"].string,
              workNumber: item["workNumber"].string,
              email: item["email"].string,
              additionalNumbers: item["additionalNumbs"].string,
              company: item["companyName"].string,
              job: item["jobName"].string,
              department: item["departmentName"].string)
            self.employees?.append(employee)
          }
//          { name: 'Кучин Сергей Сергеевич', phoneNumber: '79505439887', workNumber: '2043', email: 'kuchinsergey5002@gmail.com', additionalNumbs: '73432861080', companyName: 'ООО Ромашка', jobName: 'Инженер-программист', departmentName: 'Отдел разработок' }
          log.info("Finished loading")
          tableView.dg_stopLoading()
          tableView.reloadData()
        }
    }
    return true
  }
  
  func titleForEmptyDataSet(scrollView: UIScrollView) -> NSAttributedString? {
    
    let attributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(20), NSForegroundColorAttributeName: UIColor.grayColor()]
    
    return NSAttributedString.init(string: "Ничего не найдено", attributes: attributes)
  }
  
  func descriptionForEmptyDataSet(scrollView: UIScrollView) -> NSAttributedString? {
    
    let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(16), NSForegroundColorAttributeName: UIColor.lightGrayColor()]
    
    return NSAttributedString.init(string: "Потяните экран вниз, чтобы получить список сотрудников", attributes: attributes)
  }
  
  func backgroundColorForEmptyDataSet(scrollView: UIScrollView) -> UIColor? {
    return UIColor.whiteColor()
  }
  
  func verticalOffsetForEmptyDataSet(scrollView: UIScrollView) -> CGFloat {
    return 0
  }

  // MARK: - DZNEmptyDataSetDelegate
  func emptyDataSetShouldDisplay(scrollView: UIScrollView) -> Bool {
    return true
  }
  
  func emptyDataSetShouldFadeIn(scrollView: UIScrollView) -> Bool {
    return true
  }
  
  func emptyDataSetShouldAllowScroll(scrollView: UIScrollView) -> Bool {
    return true
  }
  
  func emptyDataSetShouldAllowTouch(scrollView: UIScrollView) -> Bool {
    return true
  }
  
  func emptyDataSet(scrollView: UIScrollView, didTapView: UIView) {
    print("didTapView: \(didTapView)")
    self.loadData(tableView)
  }
  
  func emptyDataSetWillAppear(scrollView: UIScrollView) {
    print("emptyDataSetWillAppear")
  }
  
  func emptyDataSetDidAppear(scrollView: UIScrollView) {
    print("emptyDataSetDidAppear")
  }
  
  func emptyDataSetWillDisappear(scrollView: UIScrollView) {
    print("emptyDataSetWillDisappear")
  }
  
  func emptyDataSetDidDisappear(scrollView: UIScrollView) {
    print("emptyDataSetDidDisappear")
  }

  // MARK: - UITableViewDataSource
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let emps = employees else { return 0 }
    return emps.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let emps = employees else {return tableView.dequeueReusableCellWithIdentifier("employeeCell", forIndexPath: indexPath)}
    let cell = tableView.dequeueReusableCellWithIdentifier("employeeCell", forIndexPath: indexPath)
    cell.textLabel?.text = emps[indexPath.row].name
    cell.detailTextLabel?.text = emps[indexPath.row].phoneNumber
    
    return cell
  }
}
