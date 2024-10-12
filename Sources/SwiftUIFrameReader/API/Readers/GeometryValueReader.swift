public struct GeometryValueReader<Content: View, Value: Equatable>: View {
    private var content: (Value) -> Content
    private var value: (GeometryProxy) -> Value
    
    public var body: some View {
        GeometryReader { proxy in
            Color.clear
                .hidden()
                .preference(
                    key: ReaderKey<Value>.self,
                    value: value(proxy)
                )
        }
        .overlayPreferenceValue(ReaderKey<Value>.self) { value in
            if let value {
                content(value)
            }
        }
    }
}