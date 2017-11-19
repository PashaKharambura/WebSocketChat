//
//  Message.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/14/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation

struct Message {
  
  var message: String
  var messageSender: String
  
  init(message: String, messageSender: String) {
    self.message = message.withoutWhitespace()
    self.messageSender = messageSender
  }
  
}


