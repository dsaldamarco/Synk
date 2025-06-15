//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct SharpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let hapticGenerator = UIImpactFeedbackGenerator(style: .rigid)

    var body: some View {
        ZStack {
            Image("sharp_texture")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gesture in
                            triggerHapticFeedback()
                        }
                )
        }
    }
    
    private func triggerHapticFeedback() {
        hapticGenerator.prepare()
        hapticGenerator.impactOccurred()
    }
    
}
