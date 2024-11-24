/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2025
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
