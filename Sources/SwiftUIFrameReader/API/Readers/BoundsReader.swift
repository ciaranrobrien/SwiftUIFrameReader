/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// A container view that defines its content as a function of its own bounds.
///
/// This view returns a flexible preferred size to its parent layout.
public struct BoundsReader<Content: View, Value: Equatable>: View {
    private var content: (Value) -> Content
    private var keyPath: KeyPath<BoundsProxy, Value>
    
    public var body: some View {
        GeometryReader { proxy in
            Color.clear
                .hidden()
                .preference(
                    key: ReaderKey<Value>.self,
                    value: proxy.bounds[keyPath: keyPath]
                )
        }
        .overlayPreferenceValue(ReaderKey<Value>.self) { value in
            if let value {
                content(value)
            }
        }
    }
}


public extension BoundsReader {
    init(@ViewBuilder content: @escaping (Value) -> Content)
    where Value == BoundsProxy
    {
        self.content = content
        self.keyPath = \.self
    }
    
    init(_ keyPath: KeyPath<BoundsProxy, Value>, @ViewBuilder content: @escaping (Value) -> Content) {
        self.content = content
        self.keyPath = keyPath
    }
}