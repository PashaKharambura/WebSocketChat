//
//  MessageViewControllerExtentions.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/15/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

// MARK - UITextFieldDelegate

extension MessagesViewController: UITextFieldDelegate {
  
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MessageModel.instanse.messagesArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = messageTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
    let index = indexPath.row
    cell.messageLabel.text = MessageModel.instanse.messagesArray[index].message
    cell.userName.text = ("\(MessageModel.instanse.messagesArray[index].messageSender):")
    
    if "\(MessageModel.instanse.currentUser)" == "\(MessageModel.instanse.messagesArray[index].messageSender)" {
      cell.backgroundColor = UIColor.blue
    } else {
      cell.backgroundColor = UIColor.gray
    }
    
    return cell
  }
  
}
