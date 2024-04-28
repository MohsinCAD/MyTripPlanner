//
//  APIKeyManager.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-26.
//

import Foundation

enum APIKeyError: Error {
  case keyNotFound(filename: String)
}

struct APIKeyManager {
  static var apiKey: String? {
    get {
      guard let filePath = Bundle.main.path(forResource: "APIConfig", ofType: "plist"),
        let plist = NSDictionary(contentsOfFile: filePath),
        let value = plist.object(forKey: "API_KEY") as? String else {
        print("Couldn't find key 'API_KEY' in 'APIConfig.plist'.")
        return nil
      }
      return value
    }
  }
}
