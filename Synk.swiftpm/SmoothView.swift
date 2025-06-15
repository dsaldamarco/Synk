//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct SmoothView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let hapticGenerator = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        ZStack {
            Image("smooth_texture")
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
