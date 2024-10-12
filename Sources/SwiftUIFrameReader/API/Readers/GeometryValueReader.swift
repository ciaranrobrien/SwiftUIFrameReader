/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// A container view that defines its content as a function of its own size and
/// coordinate space.
///
/// This view returns a flexible preferred size to its parent layout.
public struct GeometryValueReader<Content: View, Value: Equatable>: View {
    private var content: (Value) -> Content
    private var value: (GeometryProxy) -> Value
    
    public var body: some View {
        GeometryReader { proxy in
            Color.clear
                .hidden()
                .preference(
                    key: ReaderKey<Value>.self,
                    value: value(proxy)
                )
        }
        .overlayPreferenceValue(ReaderKey<Value>.self) { value in
            if let value {
                content(value)
            }
        }
    }
}


public extension GeometryValueReader {
    init(_ value: @escaping (GeometryProxy) -> Value, @ViewBuilder content: @escaping (Value) -> Content) {
        self.content = content
        self.value = value
    }
}
