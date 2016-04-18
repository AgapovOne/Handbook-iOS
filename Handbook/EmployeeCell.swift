//
//  EmployeeCell.swift
//  Handbook
//
//  Created by Алексей Агапов on 18/04/16.
//  Copyright © 2016 ru.urfu. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var workNumber: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
