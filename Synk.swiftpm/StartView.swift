//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct StartView: View {
    @Binding var currentView: Int
    @State private var showText = false
    @State private var navigateToNext = false

    var body: some View {
        if navigateToNext {
            ContentView()
        } else {
            GeometryReader { geometry in
                ZStack {
                    // Background with gradient
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)

                    VStack {
                        Spacer()

                        // App name
                        Text("Synk")
                            .font(.system(size: geometry.size.width * 0.15, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .opacity(showText ? 1 : 0)
                            .animation(.easeIn(duration: 1), value: showText)
                            .accessibilityLabel("Synk, the app name")

                        // Starting text
                        Text("How do you *perceive* the world?")
                            .font(.system(size: geometry.size.width * 0.06, weight: .medium, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.8))
                            .opacity(showText ? 1 : 0)
                            .animation(.easeIn(duration: 1.5).delay(0.5), value: showText)
                            .padding(.vertical, -20)
                            .accessibilityLabel("How do you perceive the world?")

                        // Emoji in the center 🔮 with animation
                        Text("🔮")
                            .font(.system(size: geometry.size.width * 0.25))
                            .opacity(showText ? 1 : 0)
                            .animation(.easeIn(duration: 1).delay(1.5), value: showText)
                            .padding(geometry.size.height * 0.02)
                            .padding(.vertical, 10)
                            .accessibilityLabel("A crystal ball emoji, representing perception.")

                        // Button to start
                        Button(action: {
                            withAnimation {
                                currentView = 1
                            }
                        }) {
                            Text("Start")
                                .font(.system(size: geometry.size.width * 0.06, weight: .semibold))
                                .padding(.vertical, geometry.size.height * 0.02)
                                .frame(maxWidth: geometry.size.width * 0.6)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(20)
                        }
                        .opacity(showText ? 1 : 0)
                        .animation(.easeIn(duration: 2).delay(2), value: showText)
                        .padding(.top, geometry.size.height * 0.05)
                        .accessibilityLabel("Start button. Tap to begin.")

                        Spacer()
                    }
                    .onAppear {
                        showText = true
                    }
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(currentView: .constant(0))
            .previewDevice("iPhone 16 Pro")
    }
}
