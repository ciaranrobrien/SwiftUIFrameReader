/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

/// A proxy for access to the size and safe area inset of the container view.
public struct BoundsProxy: Equatable, Sendable {
    
    /// The size of the container view.
    public private(set) var size: CGSize
    
    /// The safe area inset of the container view.
    public private(set) var safeAreaInsets: EdgeInsets
    
    internal init(safeAreaInsets: EdgeInsets, size: CGSize) {
        self.safeAreaInsets = safeAreaInsets
        self.size = size
    }
}


extension BoundsProxy: Animatable {
    public var animatableData: AnimatablePair<AnimatablePair<AnimatablePair<CGFloat, CGFloat>, AnimatablePair<CGFloat, CGFloat>>, AnimatablePair<CGFloat, CGFloat>>
    {
        get {
            AnimatablePair(
                AnimatablePair(
                    AnimatablePair(safeAreaInsets.top, safeAreaInsets.leading),
                    AnimatablePair(safeAreaInsets.bottom, safeAreaInsets.trailing)
                ),
                AnimatablePair(size.width, size.height)
            )
        }
        set {
            safeAreaInsets = EdgeInsets(
                top: newValue.first.first.first,
                leading: newValue.first.first.second,
                bottom: newValue.first.second.first,
                trailing: newValue.first.second.second
            )
            size = CGSize(
                width: newValue.second.first,
                height: newValue.second.second
            )
        }
    }
}
