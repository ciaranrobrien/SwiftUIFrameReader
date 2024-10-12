//
//  SwiftUIView.swift
//  SwiftUIFrameReader
//
//  Created by Ciaran O'Brien on 12/10/2024.
//

import SwiftUI

internal extension GeometryProxy {
    var bounds: BoundsProxy {
        .init(safeAreaInsets: safeAreaInsets, size: size)
    }
}
