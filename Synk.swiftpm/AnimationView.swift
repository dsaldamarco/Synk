import SwiftUI

struct AnimationView: View {
    @Binding var currentView: Int
    @State private var showFirstMessage = false
    @State private var showSecondMessage = false

    var body: some View {
        VStack {
            if showFirstMessage {
                Text("Each mind *sees* and *feels* the world in its own unique way.\n \n Learn how your perception connects to **sounds**, **shapes** and **colors**.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .transition(.opacity)
                    .accessibilityLabel("Each mind sees and feels the world in its own unique way. Learn how your perception connects to sounds, shapes, and colors.")
            }

            if showSecondMessage {
                Text("**Synesthesia** is a phenomenon in which the senses intertwine, allowing us to *see* sounds or *hear* colors. \n \n Discover your unique connections through upcoming activities.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .transition(.opacity)
                    .accessibilityLabel("Synesthesia is a phenomenon where the senses intertwine, allowing us to see sounds or hear colors. Discover your unique connections through upcoming activities.")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            if UIAccessibility.isReduceMotionEnabled {
                // Salta le animazioni se l'utente ha attivato "Riduci Movimento"
                showFirstMessage = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    showFirstMessage = false
                    showSecondMessage = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        showSecondMessage = false
                        currentView = 2
                    }
                }
            } else {
                withAnimation(.easeInOut(duration: 2)) {
                    showFirstMessage = true
                }
                UIAccessibility.post(notification: .announcement, argument: "Each mind sees and feels the world in its own unique way.")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation(.easeInOut(duration: 2)) {
                        showFirstMessage = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 2)) {
                            showSecondMessage = true
                        }
                        UIAccessibility.post(notification: .announcement, argument: "Synesthesia is a phenomenon where the senses intertwine, allowing us to see sounds or hear colors.")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation(.easeInOut(duration: 2)) {
                                showSecondMessage = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    currentView = 2
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView(currentView: .constant(1))
            .previewDevice("iPhone 16 Pro")
    }
}
