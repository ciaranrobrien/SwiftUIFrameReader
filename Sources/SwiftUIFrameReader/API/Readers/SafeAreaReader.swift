/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2025
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// A container view that defines its content as a function of its own safe area.
///
/// This view returns a flexible preferred size to its parent layout.
public struct SafeAreaReader<Content: View, Value: Equatable>: View {
    private var content: (Value) -> Content
    private var keyPath: KeyPath<EdgeInsets, Value>
    
    public var body: some View {
        GeometryReader { proxy in
            Color.clear
                .hidden()
                .preference(
                    key: EquatableReaderKey<Value>.self,
                    value: proxy.safeAreaInsets[keyPath: keyPath]
                )
        }
        .overlayPreferenceValue(EquatableReaderKey<Value>.self) { value in
            if let value {
                content(value)
            }
        }
    }
}


public extension SafeAreaReader {
    init(@ViewBuilder content: @escaping (Value) -> Content)
    where Value == EdgeInsets
    {
        self.content = content
        self.keyPath = \.self
    }
    
    init(_ keyPath: KeyPath<EdgeInsets, Value>, @ViewBuilder content: @escaping (Value) -> Content) {
        self.content = content
        self.keyPath = keyPath
    }
}
