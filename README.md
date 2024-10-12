# SwiftUI FrameReader

SwiftUI container views with a subset of `GeometryReader` features.

## Motivation

`GeometryReader` recalculates its body every time the container view's geometry changes. This can result in unnecessary recalculations if the body only depends on a subset of the container view's geometry information. For example, a child view may depend on the parent view's size but not on its position.

This package provides container views that each offer a subset of the functionality of a `GeometryReader`. These container views have the same space-filling behaviour as a `GeometryReader`, but only recalculate their body when their returned value changes.

## Get Started

Use `SizeReader`, `SafeAreaReader` or `BoundsReader` to read the size and/or safe area of the container view.

```swift
SizeReader { size in
    /// content
}
```

Use `FrameReader` to read the frame of the container view in a given coordinate space.

```swift
FrameReader(in: .global) { frame in
    /// content
}
```

## Advanced Usage

Provide a key path to any reader to read a single geometry value from the container view.

```swift
SizeReader(\.width) { width in
    /// content
}

FrameReader(\.minY, in: .global) { minY in
    /// content
}
```

Use `GeometryValueReader` to calculate and read a single geometry value from the container view.

```swift
GeometryValueReader { proxy in
    proxy.bounds(of: .scrollView)?.height
} content: { scrollViewHeight in
    /// content
}
```

## Requirements

* iOS 13.0+, macOS 10.15+, tvOS 13.0+, watchOS 6.0+, visionOS 1.0+
* Xcode 16.0+

## Installation

* Install with [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).
* Import `SwiftUIFrameReader` to start using.

## Contact

[@ciaranrobrien](https://twitter.com/ciaranrobrien) on Twitter.
