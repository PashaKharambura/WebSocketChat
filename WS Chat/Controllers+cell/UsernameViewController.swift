//
//  UsernameViewController.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/15/17.
//  Copyright © 2017 Pavlo Kharambura. All rights reserved.
//

import UIKit

final class UsernameViewController: UIViewController {

  var username = String()
  
  @IBOutlet var nextButtonItem: UIBarButtonItem!

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "usernameSelected" {
      let _ = segue.destination as! MessagesViewController
      MessageModel.instanse.setUser(userName: username)
    }
  }

// MARK: - IBActions

  @IBAction func usernameDidChange(textField: UITextField) {
    if let text = textField.text {
      nextButtonItem.isEnabled = text.characters.count > 0
      username = text
    } else {
      nextButtonItem.isEnabled = false
    }    
  }

  @IBAction func websocketDisconnectedUnwind(unwindSegue: UIStoryboardSegue) {
    username = ""
    nextButtonItem.isEnabled = false
  }
  
}
