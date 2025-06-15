//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct SynestheticResultsView: View {
    @Binding var currentView: Int
    @Binding var userName: String
    @Binding var associations: [String: Color]
    var dominantColors: [Color]
    var soundPatterns: [String]
    var shapeType: String

    @State private var showElements: [Bool] = Array(repeating: false, count: 7)

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                Text("Your synesthetic profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10)
                    .opacity(showElements[0] ? 1 : 0)
                    .animation(.easeInOut(duration: 1), value: showElements[0])
                    .accessibilityLabel("Your synesthetic profile")

                Text("Your brain connects perceptions in unique ways. Here’s how you process the world around you.")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 30)
                    .opacity(showElements[1] ? 1 : 0)
                    .animation(.easeInOut(duration: 1), value: showElements[1])
                    .accessibilityLabel("Your brain connects perceptions in unique ways. Here’s how you process the world around you.")

                // Dominant Colors Card
                createCard(title: "Dominant Colors", description: "These are the colors that your brain most often connects to words and sounds.") {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        ForEach(dominantColors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .accessibilityLabel("Color \(color.description)")
                        }
                    }
                }
                .opacity(showElements[2] ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: showElements[2])

                // Sound Patterns Card
                createCard(title: "Sound Patterns", description: "Your way of perceiving sounds follows these patterns.") {
                    VStack(alignment: .leading) {
                        ForEach(soundPatterns, id: \.self) { pattern in
                            Text("• \(pattern)")
                                .font(.body)
                                .accessibilityLabel("Sound pattern: \(pattern)")
                        }
                    }
                }
                .opacity(showElements[3] ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: showElements[3])

                // Name Shape Card
                createCard(title: "Name Shape", description: "The visual representation of your name translates into this geometry.") {
                    VStack(alignment: .leading) {
                        Text("Generated shape: \(shapeType)")
                            .font(.body)
                            .italic()
                            .accessibilityLabel("Generated shape is \(shapeType)")

                        FluffyShape(name: userName)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: dominantColors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 200, height: 130)
                            .shadow(color: dominantColors.first?.opacity(0.6) ?? Color.blue.opacity(0.6),
                                    radius: 20)
                            .padding(.top, 20)
                    }
                }
                .opacity(showElements[4] ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: showElements[4])

                // Restart Button
                Button(action: {
                    currentView = 2  // Comes back to the start of the test
                    userName = ""
                    associations.removeAll()
                }) {
                    Text("Take the test again!")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .opacity(showElements[5] ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: showElements[5])
                .accessibilityLabel("Take the test again")

                // Explore tactile illusions button
                Button(action: {
                    currentView = 9 // Brings to SynestheticExperiencesView
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
                .padding(.horizontal)
                .padding(.bottom, 40)
                .opacity(showElements[6] ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: showElements[6])
                .accessibilityLabel("Explore tactile illusions")
            }
            .padding(.horizontal)
            .onAppear {
                for i in 0..<showElements.count {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                        showElements[i] = true
                    }
                }
            }
        }
        .navigationTitle("Results")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
    }
    
    // Function to creatp card with title, description and stuff
    private func createCard<Content: View>(title: String, description: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .accessibilityLabel(title)

            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .accessibilityLabel(description)

            content()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 160, alignment: .leading) // Allineamento sinistro
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemBackground)).shadow(radius: 5))
    }
}

// Preview 
struct SynestheticResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SynestheticResultsView(
            currentView: .constant(5),
            userName: .constant("Alex"),
            associations: .constant(["Smooth": .blue, "Rough": .red]),
            dominantColors: [.blue, .purple, .pink],
            soundPatterns: ["Harmonic", "Rhythmic", "Dissonant"],
            shapeType: "Organic"
        )
    }
}
