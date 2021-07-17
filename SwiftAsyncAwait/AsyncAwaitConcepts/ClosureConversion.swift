//
//  ClosureConversion.swift
//  ClosureConversion
//
//  Created by Nilaakash Singh on 17/07/21.
//

import Foundation

/// This is an example to convert old closure with async
func oldClosure(_ completion: @escaping (Result<Data, Error>) -> Void) {
    // This is just and old closure method
}

func newClosure() async throws -> Data {
    return try await withCheckedThrowingContinuation({ continuation in
        oldClosure { result in
            switch result {
            case .success(let value):
                continuation.resume(returning: value)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }
    })
}

func work() async {
    do {
        let data = try await newClosure()
    } catch {
        print(error)
    }
}


// Xcode way of doing it
/// This is an example to convert old closure with async
@available(*, deprecated, message: "Prefer async alternative instead")
func anotherOldClosure(_ completion: @escaping (Result<Data?, Error>) -> Void) {
}
