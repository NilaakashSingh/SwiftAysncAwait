//
//  ContentView.swift
//  SwiftAsyncAwait
//
//  Created by Nilaakash Singh on 17/07/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://files.betamax.raywenderlich.com/attachments/collections/194/e12e2e16-8e69-432c-9956-b0e40eb76660.png")) { image in
          image.resizable()
        } placeholder: {
          Color.red
        }
        .frame(width: 252, height: 252)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
