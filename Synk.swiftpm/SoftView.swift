//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct SoftView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let hapticGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack {
            Image("soft_texture")
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
