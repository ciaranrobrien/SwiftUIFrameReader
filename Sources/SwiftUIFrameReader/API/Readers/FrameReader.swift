/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// A container view that defines its content as a function of its own frame.
///
/// This view returns a flexible preferred size to its parent layout.
public struct FrameReader<Content: View, Value: Equatable>: View {
    private var content: (Value) -> Content
    private var coordinateSpace: CoordinateSpace
    private var keyPath: KeyPath<CGRect, Value>
    
    public var body: some View {
        GeometryReader { proxy in
            Color.clear
                .hidden()
                .preference(
                    key: ReaderKey<Value>.self,
                    value: proxy.frame(in: coordinateSpace)[keyPath: keyPath]
                )
        }
        .overlayPreferenceValue(ReaderKey<Value>.self) { value in
            if let value {
                content(value)
            }
        }
    }
}


public extension FrameReader {
    @_disfavoredOverload
    init(
        in coordinateSpace: CoordinateSpace,
        @ViewBuilder content: @escaping (Value) -> Content
    ) where Value == CGRect
    {
        self.content = content
        self.coordinateSpace = coordinateSpace
        self.keyPath = \.self
    }
    
    @_disfavoredOverload
    init(
        _ keyPath: KeyPath<CGRect, Value>,
        in coordinateSpace: CoordinateSpace,
        @ViewBuilder content: @escaping (Value) -> Content
    ) {
        self.content = content
        self.coordinateSpace = coordinateSpace
        self.keyPath = keyPath
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    init(
        in coordinateSpace: some CoordinateSpaceProtocol,
        @ViewBuilder content: @escaping (Value) -> Content
    ) where Value == CGRect
    {
        self.content = content
        self.coordinateSpace = coordinateSpace.coordinateSpace
        self.keyPath = \.self
    }
    
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    init(
        _ keyPath: KeyPath<CGRect, Value>,
        in coordinateSpace: some CoordinateSpaceProtocol,
        @ViewBuilder content: @escaping (Value) -> Content
    ) {
        self.content = content
        self.coordinateSpace = coordinateSpace.coordinateSpace
        self.keyPath = keyPath
    }
}
