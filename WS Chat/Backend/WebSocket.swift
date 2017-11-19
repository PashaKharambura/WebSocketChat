//
//  WebSocket.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/19/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import Starscream

class WebSocketServise: WebSocketDelegate {
  
  var socket = WebSocket(url: URL(string: "ws://localhost:1337/")!, protocols: ["chat"])
  
  func connecting() {
    socket.delegate = self
    socket.connect()
  }
  
  func disconecting() {
    socket.disconnect(forceTimeout: 0)
    socket.delegate = nil
  }
  // MARK: Sending MEssages
  
  func sendMessage(_ message: String) {
    socket.write(string: message)
  }
  
  public func websocketDidConnect(_ socket: Starscream.WebSocket) {
    socket.write(string: MessageModel.instanse.currentUser)
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
    
        messageReceived(messageText, senderName: messageAuthor, callback: { (message) in
          MessageModel.instanse.addMessage(message: message)
        })
      }
  }
  
  func messageReceived(_ message: String, senderName: String, callback: @escaping (_ message: Message)->()) {
    let newMessage = Message(message: message, messageSender: senderName)
    callback(newMessage)
  }
  
  public func websocketDidReceiveData(_ socket: Starscream.WebSocket, data: Data) {
    
  }
  
  func websocketDidWriteError(error: NSError?, callback: @escaping (_ error: Error?)->()) {
    if let error = error {
      callback(error)
      print("wez got an error from the websocket: \(error.localizedDescription)")
    }
  }
  
  public func websocketDidDisconnect(_ socket: Starscream.WebSocket, error: NSError?) {
    if let error = error {
      print("websocket is disconnected by error: \(error.localizedDescription)")
      if error.code == 61 {
         print("Server is not runned!")
      }
    }
  }
  
}
