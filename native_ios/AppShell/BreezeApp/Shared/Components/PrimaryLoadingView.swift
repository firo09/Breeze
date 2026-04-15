#if canImport(SwiftUI)
import SwiftUI

struct PrimaryLoadingView: View {
    var body: some View {
        ProgressView("Loading...")
            .progressViewStyle(.circular)
    }
}
#endif
