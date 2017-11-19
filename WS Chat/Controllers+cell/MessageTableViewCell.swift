//
//  MessageTableViewCell.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/14/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
