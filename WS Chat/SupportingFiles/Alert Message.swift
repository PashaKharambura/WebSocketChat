//
//  Alert Message.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/15/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

class AlertDialog {
  
  class func showAlert(_ title: String, message: String, viewController: UIViewController) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(dismissAction)
    
    viewController.present(alertController, animated: true, completion: nil)
    
  }
  
}
