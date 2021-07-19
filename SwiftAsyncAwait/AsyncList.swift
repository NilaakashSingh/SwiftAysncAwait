//
//  AsyncList.swift
//  AsyncList
//
//  Created by Nilaakash Singh on 19/07/21.
//

import SwiftUI

struct AsyncList: View {
    @StateObject var jokeService = Service()
    
    var body: some View {
        List {
            Text("Chuck Norris Joke")
                .font(.largeTitle)
                .listRowSeparator(.hidden)
            Text(jokeService.joke)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .lineSpacing(5.0)
                .padding()
                .font(.title)
        }
        .task {
            try? await jokeService.fetchJoke()
        }
        .refreshable {
            try? await jokeService.fetchJoke()
        }
    }
}

struct AsyncList_Previews: PreviewProvider {
    static var previews: some View {
        AsyncList()
    }
}

