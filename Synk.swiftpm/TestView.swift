//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct TestView: View {
    @Binding var currentView: Int
    @Binding var associations: [String: Color]
    
    @State private var words = ["Happy", "Sad", "Angry", "Calm", "Fear", "Surprised"]
    @State private var colors: [Color] = [.yellow, .blue, .red, .gray, .purple, .green, .orange, .pink, .black, .brown]
    
    @State private var selectedColor: Color? = nil
    @State private var matches: [String: Color] = [:]
    
    @State private var showText = false
    @State private var showWords = [false, false, false, false, false, false]
    @State private var showColors = false
    @State private var showButton = false
    
    var allMatched: Bool {
        return matches.count == words.count
    }
    
    var body: some View {
        VStack {
            // Initial text with fading
            if showText {
                Text("Choose a **color**, then\ntap a **word** to assign it.\nFinish the process with\nall the words.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .opacity(showText ? 1 : 0)
                    .animation(.easeIn(duration: 1), value: showText)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .accessibilityLabel("Choose a color, then tap a word to assign it. Finish the process with all the words.")
            }
            
            // Words that appear one by one
            VStack(spacing: 15) {
                ForEach(words.indices, id: \ .self) { index in
                    if showWords[index] {
                        Text(words[index])
                            .font(.headline)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(matches[words[index]] ?? Color.gray.opacity(0.4))
                            .foregroundColor(contrastColor(for: matches[words[index]] ?? Color.gray.opacity(0.2)))
                            .cornerRadius(10)
                            .transition(.opacity.combined(with: .scale))
                            .onTapGesture {
                                if let color = selectedColor {
                                    matches[words[index]] = color
                                    UIAccessibility.post(notification: .announcement, argument: "\(words[index]) assigned to \(color.description)")
                                }
                            }
                            .accessibilityLabel("\(words[index]), assigned color: \(matches[words[index]]?.description ?? "none")")
                    }
                }
            }
            
            Spacer().frame(height: 30)
            
            // Color selection that appear after the words
            if showColors {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 5), spacing: 10) {
                    ForEach(colors, id: \ .self) { color in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(color)
                            .frame(width: 50, height: 40)
                            .overlay(
                                selectedColor == color ? Image(systemName: "checkmark.circle.fill").foregroundColor(.white) : nil
                            )
                            .onTapGesture {
                                selectedColor = color
                                UIAccessibility.post(notification: .announcement, argument: "Selected color: \(color.description)")
                            }
                            .accessibilityLabel("Color \(color.description)")
                    }
                }
                .padding(.horizontal)
                .transition(.opacity)
            }
            
            // "Finish" button that appears at the end of the animation
            if showButton {
                Button(action: {
                    associations = matches
                    withAnimation { currentView = 3 }
                }) {
                    Text("Finish")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(
                            allMatched ? AnyView(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            ) : AnyView(Color.gray)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!allMatched)
                .transition(.opacity)
                .padding(.top)
                .accessibilityLabel("Finish button, \(allMatched ? "active" : "disabled")")
            }
        }
        .onAppear {
            // Animations in sequence
            withAnimation(.easeIn(duration: 1)) {
                showText = true
            }
            
            for i in words.indices {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 + Double(i) * 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showWords[i] = true
                    }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 + Double(words.count) * 0.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    showColors = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 + Double(words.count) * 0.5 + 1.5) {
                withAnimation(.easeInOut(duration: 1)) {
                    showButton = true
                }
            }
        }
    }
    
    func contrastColor(for background: Color) -> Color {
        return (background == .yellow || background == .green) ? .black : .white
    }
}
