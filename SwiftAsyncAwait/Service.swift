//
//  Service.swift
//  Service
//
//  Created by Nilaakash Singh on 19/07/21.
//

import Foundation

class JokeService: ObservableObject {
    
    @Published private(set) var joke = "Joke appears here"
    @Published private(set) var isFetching = false
    
    private var url: URL { urlComponents.url! }
    
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.chucknorris.io"
        components.path = "/jokes/random"
        components.setQueryItems(with: ["category": "dev"])
        return components
    }
}

extension JokeService {
    func fetchJoke() {
        isFetching = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer {
                DispatchQueue.main.async {
                    self.isFetching = false
                }
            }
            if let data = data, let response = response as? HTTPURLResponse {
                print(response.statusCode)
                if let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data) {
                    DispatchQueue.main.async {
                        self.joke = decodedResponse.value
                    }
                    return
                }
            }
            print("Joke fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
}

struct Joke: Codable {
    let value: String
}

extension URLComponents {
    /// Maps a dictionary into `[URLQueryItem]` then assigns it to the
    /// `queryItems` property of this `URLComponents` instance.
    /// From [Alfian Losari's blog.](https://www.alfianlosari.com/posts/building-safe-url-in-swift-using-urlcomponents-and-urlqueryitem/)
    /// - Parameter parameters: Dictionary of query parameter names and values
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
