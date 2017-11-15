//
//  MessagesViewController.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/14/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit
import Starscream

final class MessagesViewController: UIViewController {

  // MARK: - Properties
    var username = String()
    var messageArray = [Message]()
    var socket = WebSocket(url: URL(string: "ws://localhost:1337/")!, protocols: ["chat"])
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  // MARK: - IBOutlets

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    override func viewDidLoad() {
      super.viewDidLoad()

      NotificationCenter.default.addObserver(self, selector: #selector(MessagesViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(MessagesViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

      socket.delegate = self
      socket.connect()
      gettingMessages(callback: messageTableView.reloadData)
      navigationItem.hidesBackButton = false
    }
  
    deinit {
      socket.disconnect(forceTimeout: 0)
      socket.delegate = nil
    }
  
// MARK: - IBActions
    @IBAction func sendMessageButton(_ sender: UIButton) {
      if messageTextField.text != "" {
        sendMessage(messageTextField.text!)
      }
    }

  // MARK: - Keyboard appearence
  
    func keyboardWillShow(notification: NSNotification) {
      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        if self.view.frame.origin.y == 0{
          self.view.frame.origin.y -= keyboardSize.height
        }
      }
    }
  
    func keyboardWillHide(notification: NSNotification) {
      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        if self.view.frame.origin.y != 0{
          self.view.frame.origin.y += keyboardSize.height
        }
      }
    }

}



