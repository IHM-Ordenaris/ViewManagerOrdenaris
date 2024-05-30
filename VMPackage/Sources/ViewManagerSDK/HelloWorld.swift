//
//  HelloWorld.swift
//  ViewManagerSDK
//
//  Created by Ignacio Hernández on 02/08/23.
//

import Foundation


public class HelloWorld {
    let hello = "Hello"

    public init() {}

    public func hello(to whom: String) -> String {
        return "Hello \(whom)"
    }
}
