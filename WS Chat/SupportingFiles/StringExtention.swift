//
//  StringExtention.swift
//  WS Chat
//
//  Created by Pavlo Kharambura on 11/15/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation

extension String {
  func withoutWhitespace() -> String {
    return self.replacingOccurrences(of: "\n", with: "")
      .replacingOccurrences(of: "\r", with: "")
      .replacingOccurrences(of: "\0", with: "")
  }
}
