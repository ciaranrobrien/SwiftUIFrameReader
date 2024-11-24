/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2025
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// A container view that defines its content as a function of its own size and
/// coordinate space.
///
/// This view returns a flexible preferred size to its parent layout.
public struct GeometryValueReader<Content: View, Value>: View {
    private var content: (Value) -> Content
    private var equal: (Value, Value) -> Bool
    private var value: (GeometryProxy) -> Value
    
    public var body: some View {
        GeometryReader { proxy in
            Color.clear
                .hidden()
                .transformPreference(ReaderKey<Value>.self) { value in
                    let newValue = self.value(proxy)
                    
                    if let oldValue = value, equal(oldValue, newValue) {
                        return
                    } else {
                        value = newValue
                    }
                }
        }
        .overlayPreferenceValue(ReaderKey<Value>.self) { value in
            if let value {
                content(value)
            }
        }
    }
}


public extension GeometryValueReader {
    init(
        _ value: @escaping (GeometryProxy) -> Value,
        @ViewBuilder content: @escaping (Value) -> Content
    ) where Value : Equatable
    {
        self.content = content
        self.equal = Value.equal
        self.value = value
    }
    
    @_disfavoredOverload
    init(
        _ value: @escaping (GeometryProxy) -> Value,
        equal: @escaping (Value, Value) -> Bool,
        @ViewBuilder content: @escaping (Value) -> Content
    )
    {
        self.content = content
        self.equal = equal
        self.value = value
    }
}
