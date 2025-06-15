//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct TestResultView: View {
    let correctChoice: Bool
    let onContinue: () -> Void
    
    @State private var showExplanation = false
    @State private var showDetails = false
    @State private var showFunFact = false
    @State private var showContinueButton = false
    
    private let funFactDelay: Double = 2.0   // Time after Fun Fact appears
    private let continueButtonDelay: Double = 3.5  // Time after Fun Fact to shot button
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            
            ZStack(alignment: .bottom) {
                Text(correctChoice ? "**98%** of people think\n **like you!**" : "**Only 2% of people** think **like you!**")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.5)) {
                            showExplanation = true
                        }
                    }
                    .accessibilityLabel(correctChoice ? "98 percent of people think like you" : "Only 2 percent of people think like you")
                
                RoundedRectangle(cornerRadius: 2)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(height: 5)
                    .offset(y: 10)
                    .padding(.horizontal, 120)
            }
            .padding()
            
            
            if showExplanation {
                HStack {
                    if showDetails {
                        Image(systemName: correctChoice ? "checkmark.seal.fill" : "shuffle")
                            .foregroundColor(correctChoice ? .blue : .red)
                            .font(.title)
                            .padding(.leading)
                            .transition(.opacity)
                            .accessibilityHidden(true)
                    }
                    
                    if showDetails {
                        Text(correctChoice ?
                             "Almost everyone spontaneously associates Bouba with the rounded shape and Kiki with the spiky one." :
                             "Although most people make the opposite association, there is no right or wrong answer."
                        )
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .transition(.opacity)
                        .accessibilityLabel(correctChoice ? "Most people associate Bouba with a rounded shape and Kiki with a spiky shape." : "There is no right or wrong answer, even if most people associate differently.")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .onAppear {
                    withAnimation(.easeIn(duration: 0.5).delay(1)) {
                        showDetails = true
                    }
                    withAnimation(.easeIn(duration: 0.5).delay(funFactDelay)) {
                        showFunFact = true
                    }
                }
            }
            
            // Fun Fact
            if showFunFact {
                VStack(alignment: .leading, spacing: 10) {
                    Text("🔎 Did you know?")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.primary) // 🔹 Testo adattivo
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color(UIColor.systemBackground)) // 🔹 Sfondo adattivo
                        .cornerRadius(10)
                        .transition(.opacity)
                        .accessibilityLabel("Did you know?")
                    
                    Text(correctChoice ?
                         "This experiment has been studied in many different languages and cultures!\n\nSome researchers believe that this effect can explain how humans started associating sounds with meanings in language." :
                         "Some people with synesthesia may have more personal and subjective associations between sounds and shapes.\n\nArtists like Kandinsky, Klee, and Kupka associated painting with music, using colors and forms to translate sound into visual expression."
                    )
                    .italic()
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel(correctChoice ? "This experiment has been studied across different languages and cultures. Some researchers think it might explain how humans began linking sounds with meanings." : "People with synesthesia may experience more personal associations between sounds and shapes. Artists like Kandinsky and Klee translated sound into visual forms.")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .transition(.opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0).delay(continueButtonDelay)) {
                        showContinueButton = true
                    }
                }
            }
            
            Spacer()
            
            // Button "Continue"
            if showContinueButton {
                Button(action: onContinue) {
                    Text("Continue")
                        .font(.title2)
                        .padding()
                        .frame(width: 200)
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .cornerRadius(10)
                        )
                }
                .padding(.bottom, 40)
                .transition(.opacity)
                .accessibilityLabel("Continue button")
                .accessibilityHint("Double tap to proceed to the next screen")
            }
        }
    }
}

#Preview {
    TestResultView(correctChoice: true, onContinue: {})
}
