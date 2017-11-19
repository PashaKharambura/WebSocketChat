//
//  MessagesViewController.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/14/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import UIKit
import Starscream

final class MessagesViewController: UIViewController, UITextFieldDelegate {

  // MARK: - Properties

    let context   = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let mySocket  = WebSocketServise()
  
  // MARK: - IBOutlets

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    override func viewDidLoad() {
      super.viewDidLoad()

      NotificationCenter.default.addObserver(self, selector: #selector(self.mainMessageFunction), name: NSNotification.Name(rawValue: "updateNotification"), object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

      mySocket.connecting()
      gettingMessages(callback: messageTableView.reloadData)
      navigationItem.hidesBackButton = false

    }
  
    deinit {
      mySocket.disconecting()
    }
  
  // MARK: - IBActions
  
    @IBAction func sendMessageButton(_ sender: UIButton) {
      if messageTextField.text != "" {
        mySocket.sendMessage(messageTextField.text!)
      }
    }
    
  // MARK: - Notifications
  
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

    func mainMessageFunction(notif: NSNotification) {
      messageTableView.reloadData()
      messageTextField.text = ""
      messageTextField.resignFirstResponder()
      savingMessageHistory(message: MessageModel.instanse.messagesArray.last!)
      scrollToLastRow()
    }
}
