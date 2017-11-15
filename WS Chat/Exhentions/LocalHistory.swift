//
//  LocalHistory.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/15/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

extension MessagesViewController {
  
  func savingMessageHistory(message: Message) {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let task = SavedMessage(context: context)
    task.message = message.message
    task.messageSender = message.messageSender
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
  }
  
  func gettingMessages(callback: @escaping ()->()) {
    do {
      let array: [SavedMessage] = try context.fetch(SavedMessage.fetchRequest())
      for i in 0..<array.count {
        let newMessage = Message(message: array[i].message!, messageSender: array[i].messageSender!)
        messageArray.append(newMessage)
        callback()
      }
    }
    catch {
      print("Fetching Failed")
    }
  }
  
}
