#if canImport(SwiftUI)
import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationStack {
            Text("Home Feature Shell")
                .navigationTitle("Home")
        }
    }
}
#endif
