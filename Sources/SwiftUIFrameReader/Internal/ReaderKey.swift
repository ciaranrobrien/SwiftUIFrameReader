/**
*  SwiftUIFrameReader
*  Copyright (c) Ciaran O'Brien 2025
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct ReaderKey<Value>: PreferenceKey {
    static var defaultValue: Value? { nil }
    
    static func reduce(value: inout Value?, nextValue: () -> Value?) {
        value = nextValue()
    }
}
