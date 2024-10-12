/**
*  SwiftUIBoundsReader
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import SwiftUI

internal struct ReaderKey<Value: Equatable>: PreferenceKey {
    static var defaultValue: Value? { nil }
    
    static func reduce(value: inout Value?, nextValue: () -> Value?) {
        let nextValue = nextValue()
        
        if value != nextValue {
            value = nextValue
        }
    }
}
