//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct TestView3: View {
    @Binding var currentView: Int

    @State private var smoothMovement = false
    @State private var jerkyMovement = false
    @State private var showExplanation = false
    @State private var userChoice: String? = nil

    var body: some View {
        if showExplanation {
            VStack {
                Spacer()

                Text("Our brain connects **fluid motion** to softer sounds and **jerky motion** to sharper sounds.\n\nIt is a natural perceptual effect!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: 300)
                    .transition(.opacity)
                    .padding(.bottom, 20)
                    .accessibilityLabel("Our brain connects fluid motion to softer sounds and jerky motion to sharper sounds. It is a natural perceptual effect!")

                Button(action: {
                    withAnimation { currentView = 4 }  // Go to next view
                }) {
                    Text("Continue")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .transition(.opacity)
                .padding(.top, 20)
                .accessibilityLabel("Continue to the next step")

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Occupy all the screen
        }
        else {
            VStack {
                Text("Which one seems like it would have a **higher-pitched sound?**")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .opacity(showExplanation ? 0 : 1)  // Hides title after choosing
                    .accessibilityLabel("Which one seems like it would have a higher-pitched sound?")
                
                Text("(Select one by tapping on it)")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(2)
                    .opacity(showExplanation ? 0 : 1) // Hides question
                    .accessibilityHidden(true)
                
                Spacer()
                
                // Fluid motion
                if !showExplanation {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 50, height: 50)
                        .offset(x: smoothMovement ? 100 : -100)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: smoothMovement)
                        .onAppear { smoothMovement.toggle() }
                        .onTapGesture {
                            userChoice = "Fluid"
                            withAnimation { showExplanation = true }
                        }
                        .accessibilityLabel("Smooth moving blue circle. Tap to select.")
                }
                
                Spacer().frame(height: 80)
                
                // Jerky movement
                if !showExplanation {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                        .offset(x: jerkyMovement ? 100 : -100)
                        .animation(.interpolatingSpring(stiffness: 50, damping: 2).repeatForever(autoreverses: true), value: jerkyMovement)
                        .onAppear { jerkyMovement.toggle() }
                        .onTapGesture {
                            userChoice = "Jerky"
                            withAnimation { showExplanation = true }
                        }
                        .accessibilityLabel("Jerky moving red circle. Tap to select.")
                }
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    TestView3(currentView: .constant(4))
}
