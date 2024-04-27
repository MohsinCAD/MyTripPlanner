//
//  NetworkingService.swift
//  MyTripPlanner
//
//  Created by Mohsin on 2024-04-26.
//

import Foundation
import SwiftUI

class PexelsService {
  private let apiKey = APIKeyManager.apiKey
  private let baseURL = "https://api.pexels.com/v1/search"

  func fetchImageURL(city: String, completion: @escaping (URL?) -> Void) {
    guard let url = URL(string: "\(baseURL)?query=\(city)&per_page=1") else {
      completion(nil)
      return
    }

    var request = URLRequest(url: url)
    request.setValue(apiKey, forHTTPHeaderField: "Authorization")

    URLSession.shared.dataTask(with: request) { data, _, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }

      let decoder = JSONDecoder()
      if let result = try? decoder.decode(PexelsResponse.self, from: data),
        let firstPhoto = result.photos.first {
        completion(URL(string: firstPhoto.src.medium))
      } else {
        completion(nil)
      }
    }.resume()
  }

  struct PexelsResponse: Codable {
    let photos: [Photo]

    struct Photo: Codable {
      let src: Source

      struct Source: Codable {
        let medium: String
      }
    }
  }
}
