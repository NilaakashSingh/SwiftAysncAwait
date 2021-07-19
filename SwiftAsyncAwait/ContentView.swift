//
//  ContentView.swift
//  SwiftAsyncAwait
//
//  Created by Nilaakash Singh on 17/07/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var jokeService = Service()
    
    var body: some View {
        ZStack {
            Text(jokeService.joke)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            VStack {
                Spacer()
                Button {
                    Task {
                        try? await jokeService.fetchJoke()
                      }
                    } label: {
                    Text("Fetch a joke")
                        .padding(.bottom)
                        .opacity(jokeService.isFetching ? 0 : 1)
                        .overlay {
                            if jokeService.isFetching { ProgressView() }
                        }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
