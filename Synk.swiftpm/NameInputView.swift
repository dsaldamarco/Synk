//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct NameInputView: View {
    @Binding var currentView: Int
    @Binding var userName: String
    @State private var showElements = false

    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                // 🔹 Animazione icona superiore
                Image(systemName: "sparkles")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.blue.opacity(0.8))
                    .opacity(showElements ? 1 : 0)
                    .scaleEffect(showElements ? 1 : 0.5)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: showElements)
                
                // 🔹 Testo introduttivo
                Text("Imagine if all *words* had a **shape**.\nType your name and let's find out!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .opacity(showElements ? 1 : 0)
                    .offset(y: showElements ? 0 : -20)
                    .animation(.easeOut(duration: 0.8), value: showElements)
                
                // 🔹 TextField con effetto glassmorphism
                TextField("Enter your name...", text: $userName)
                    .padding(15)
                    .frame(width: 260)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(userName.isEmpty ? Color.gray.opacity(0.5) : Color.blue, lineWidth: 1)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                    )
                    .multilineTextAlignment(.center)
                    .opacity(showElements ? 1 : 0)
                    .offset(y: showElements ? 0 : -20)
                    .animation(.easeOut(duration: 0.8).delay(0.2), value: showElements)
                    .padding(.bottom)
                
                // 🔹 Bottone con feedback tattile
                Button(action: {
                    if !userName.isEmpty {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred() // Haptic feedback
                        withAnimation { currentView += 1 } // Passa a NameShapeView
                    }
                }) {
                    Text("Confirm")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: userName.isEmpty
                                    ? [Color.gray.opacity(0.5), Color.gray.opacity(0.5)]
                                    : [Color.blue, Color.purple]
                                ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: userName.isEmpty ? .clear : Color.blue.opacity(0.4), radius: 10)
                        .opacity(userName.isEmpty ? 0.6 : 1)
                        .animation(.easeOut(duration: 0.3), value: userName)
                }
                .disabled(userName.isEmpty)
                .opacity(showElements ? 1 : 0)
                .offset(y: showElements ? 0 : -20)
                .animation(.easeOut(duration: 0.8).delay(0.4), value: showElements)
            }
        }
        .onAppear {
            showElements = true
        }
    }
}

#Preview {
    NameInputView(currentView: .constant(0), userName: .constant(""))
}
