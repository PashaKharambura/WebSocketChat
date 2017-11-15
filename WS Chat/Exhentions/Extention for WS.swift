//
//  Extention for WS.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/15/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit
import Starscream

// MARK: - WebSocketDelegate

extension MessagesViewController : WebSocketDelegate {
  
  public func websocketDidConnect(_ socket: Starscream.WebSocket) {
    socket.write(string: username)
  }
  
  public func websocketDidReceiveMessage(_ socket: Starscream.WebSocket, text: String) {
    
    guard let data = text.data(using: .utf16),
      let jsonData = try? JSONSerialization.jsonObject(with: data),
      let jsonDict = jsonData as? [String: Any],
      let messageType = jsonDict["type"] as? String else {
        return
    }
    
    if messageType == "message",
      let messageData = jsonDict["data"] as? [String: Any],
      let messageAuthor = messageData["author"] as? String,
      let messageText = messageData["text"] as? String {
      
      messageReceived(messageText, senderName: messageAuthor, callback: messageTableView.reloadData)
    }
  }
  
  public func websocketDidReceiveData(_ socket: Starscream.WebSocket, data: Data) {
    
  }
  
  public func websocketDidDisconnect(_ socket: Starscream.WebSocket, error: NSError?) {
    if let error = error {
      print("websocket is disconnected by error: \(error.localizedDescription)")
      if error.code == 61 {
          navigationController?.popViewController(animated: true)
          AlertDialog.showAlert("Error", message: "No connection to server. Check and run server again", viewController: self)
      }
    } 
  }
}

// MARK: - Sending messages

extension MessagesViewController {
  func sendMessage(_ message: String) {
    socket.write(string: message)
  }
  
  func messageReceived(_ message: String, senderName: String, callback: @escaping ()->()) {
    let newMessage = Message(message: message, messageSender: senderName)
    messageArray.append(newMessage)
    savingMessageHistory(message: newMessage)
    messageTextField.text = nil
    messageTextField.resignFirstResponder()
    callback()
    if messageArray.count > 0 {
      messageTableView.scrollToRow(at: IndexPath(item:messageArray.count-1, section: 0), at: .bottom, animated: true)
    }
  }
}
