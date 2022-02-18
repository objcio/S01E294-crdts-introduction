//
//  ContentView.swift
//  Shared
//
//  Created by Chris Eidhof on 10.02.22.
//

import SwiftUI

struct Max<Value: Comparable>: Equatable {
    var value: Value
    
    mutating func merge(_ other: Self) {
        value = max(value, other.value)
    }
    
    func merged(_ other: Self) -> Self {
        var copy = self
        copy.merge(other)
        return copy
    }
}

extension Max: Decodable where Value: Decodable { }
extension Max: Encodable where Value: Encodable { }

struct ContentView: View {
    @StateObject var session = Session<Max<Int>>()
    @State var int = Max<Int>(value: 0)
    
    var body: some View {
        VStack {
            Stepper("\(int.value)", value: $int.value)
        }
        .fixedSize()
        .padding(30)
        .onChange(of: int) { newValue in
            try! session.send(newValue)
        }
        .task {
            for await newValue in session.receiveStream {
                int.merge(newValue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
