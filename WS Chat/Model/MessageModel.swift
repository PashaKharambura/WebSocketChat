//
//  MEssageModel.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/19/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import Starscream

class MessageModel {
  
  static var instanse = MessageModel()
  private (set) var currentUser   = String()
  private (set) var messagesArray = [Message]() {
    didSet {
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateNotification"), object: nil)
    }
  }
  
  func addMessage(message: Message) {
    messagesArray.append(message)
  }
  
  func setUser(userName: String) {
    currentUser = userName
  }

}
