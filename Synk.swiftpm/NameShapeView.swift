//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct NameShapeView: View {
    @Binding var currentView: Int
    var userName: String
    var selectedColors: [Color]
    @Binding var selectedShape: String
    @State private var showText = false
    @State private var showShape = false
    @State private var glowEffect = false
    @State private var offsetY: CGFloat = 0.0
    @State private var randomSounds: [String] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), Color(.systemGray6)]),
                               startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if showShape {
                        VStack(spacing: 14) {
                            Text(userName)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding(.top, 10)
                            
                            Text("Your name feels like a \(selectedShape)")
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                            
                            FluffyShape(name: userName)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: selectedColors.isEmpty ? [.blue, .purple] : selectedColors),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 200, height: 130)
                                .shadow(color: glowEffect ? selectedColors.first?.opacity(0.6) ?? Color.blue.opacity(0.6) : .clear, radius: 20)
                                .scaleEffect(glowEffect ? 1.05 : 1)
                                .offset(y: offsetY)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.2)) {
                                        glowEffect = true
                                    }
                                    withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                                        offsetY = -10
                                    }
                                }
                                .animation(.spring(response: 1, dampingFraction: 0.5), value: showShape)
                            
                            VStack(spacing: 12) {
                                Button(action: {
                                    currentView = 8  // 🔥 Torna ai risultati
                                }) {
                                    Text("See Results")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.purple)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                        .shadow(radius: 5)
                                }
                                
                                Button(action: {
                                    currentView = 9  // 🔥 Esplora illusioni tattili
                                }) {
                                    Text("Explore tactile illusions")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    ),
                                                    lineWidth: 2
                                                )
                                        )
                                        .foregroundColor(.blue)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                            .padding(40)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 10)
                        )
                        .padding()
                        .transition(.opacity.combined(with: .scale))
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showShape = true
                }
                selectedShape = NameShapeView.randomNameShape()
                randomSounds = NameShapeView.randomSoundPatterns()
            }
        }
    }
}

// MARK: - Helper Methods
extension NameShapeView {
    static func randomSoundPatterns() -> [String] {
        let allPatterns = [
            "Soft waves", "Syncopated rhythms", "Ethereal tones", "Chiming bells",
            "Resonant echoes", "Harmonic hum", "Mechanical clicks", "Melodic pulses",
            "Swirling harmonies", "Deep vibrations"
        ]
        return Array(allPatterns.shuffled().prefix(3))
    }
    
    static func randomNameShape() -> String {
        let allShapes = [
            "Fluid spiral", "Soft blob", "Gentle ripples", "Floating bubble",
            "Whirling swirl", "Cloudy puff", "Wavy contour", "Morphing oval",
            "Billowing curve", "Misty loop", "Bouncing wave", "Stretchy ellipse",
            "Drifting whorl", "Rolling dune", "Velvet coil", "Airy curl",
            "Dreamy arc", "Ethereal swirl", "Foamy ring", "Spherical mist"
        ]
        return allShapes.randomElement() ?? "Fluid spiral"
    }
}
