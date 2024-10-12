/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal extension GeometryProxy {
    var bounds: BoundsProxy {
        BoundsProxy(safeAreaInsets: safeAreaInsets, size: size)
    }
}
