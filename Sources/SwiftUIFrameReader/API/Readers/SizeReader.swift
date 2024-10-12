/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// A container view that defines its content as a function of its own size.
///
/// This view returns a flexible preferred size to its parent layout.
public struct SizeReader<Content: View, Value: Equatable>: View {
    private var content: (Value) -> Content
    private var keyPath: KeyPath<CGSize, Value>
    
    public var body: some View {
        GeometryReader { proxy in
            Color.clear
                .hidden()
                .preference(
                    key: ReaderKey<Value>.self,
                    value: proxy.size[keyPath: keyPath]
                )
        }
        .overlayPreferenceValue(ReaderKey<Value>.self) { value in
            if let value {
                content(value)
            }
        }
    }
}


public extension SizeReader {
    init(@ViewBuilder content: @escaping (Value) -> Content)
    where Value == CGSize
    {
        self.content = content
        self.keyPath = \.self
    }
    
    init(_ keyPath: KeyPath<CGSize, Value>, @ViewBuilder content: @escaping (Value) -> Content) {
        self.content = content
        self.keyPath = keyPath
    }
}

