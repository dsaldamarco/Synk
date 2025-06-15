//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct TestView4: View {
    @Binding var currentView: Int
    
    let words = ["Wind", "Rust", "Crystal", "Velvet"]
    let flavors = ["🍰 Sweet", "🥨 Savory", "🍋 Sour", "☕ Bitter"]
    
    @State private var selectedWord: String? = nil
    @State private var selectedFlavor: String? = nil
    @State private var selectedFlavors: [String: String] = [:]
    @State private var showExplanation = false
    
    var allSelected: Bool {
        return selectedFlavors.count == words.count
    }
    
    var body: some View {
        VStack {
            Text("If these words had a **taste**, what would it be?")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .opacity(showExplanation ? 0.3 : 1.0)
                .accessibilityLabel("If these words had a taste, what would it be?")
                .accessibilityHint("Tap a word, then select a flavor to match it.")
            
            Spacer().frame(height: 20)
            
            // Section for words
            VStack(spacing: 15) {
                ForEach(words, id: \.self) { word in
                    Text(word)
                        .font(.headline)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(selectedWord == word ? Color.blue.opacity(0.2) : Color(UIColor.systemGray5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                if let flavor = selectedFlavors[word] {
                                    Text(flavor)
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            .padding(.top, 35)
                        )
                        .onTapGesture {
                            if let flavor = selectedFlavor {
                                selectedFlavors[word] = flavor
                                selectedFlavor = nil
                            } else {
                                selectedWord = word
                            }
                        }
                        .accessibilityLabel("Word: \(word)")
                        .accessibilityHint(selectedFlavors[word] != nil ? "Paired with \(selectedFlavors[word]!)" : "Tap to select this word")
                }
            }
            
            Spacer().frame(height: 30)
            
            // Section for flavors
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                ForEach(flavors, id: \.self) { flavor in
                    Button(action: {
                        if let word = selectedWord {
                            selectedFlavors[word] = flavor
                            selectedWord = nil
                        } else {
                            selectedFlavor = flavor
                        }
                        
                        // Se entrambi sono selezionati, abbina automaticamente
                        if let word = selectedWord, let flavor = selectedFlavor {
                            selectedFlavors[word] = flavor
                            selectedWord = nil
                            selectedFlavor = nil
                        }
                    }) {
                        HStack {
                            Text(flavor)
                            if selectedFlavors.contains(where: { $0.value == flavor }) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .frame(width: 120, height: 50)
                        .background(selectedFlavor == flavor ? Color.blue.opacity(0.2) : Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                    }
                    .accessibilityLabel("Flavor: \(flavor)")
                    .accessibilityHint(selectedFlavor == flavor ? "Selected" : "Tap to choose this flavor")
                }
            }
            
            Spacer()
            
            if allSelected {
                if showExplanation {
                    Text("For some people, words have a **real flavor**. \nYour brain is playing with associations!")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.bottom)
                        .transition(.opacity)
                        .accessibilityLabel("For some people, words have a real flavor. Your brain is playing with associations!")
                }
                
                Button(action: {
                    if showExplanation {
                        withAnimation { currentView += 1 }
                    } else {
                        withAnimation { showExplanation = true }
                    }
                }) {
                    Text(showExplanation ? "Continue" : "Confirm")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                .accessibilityLabel(showExplanation ? "Continue to next step" : "Confirm your selections")
            }
        }
        .padding()
    }
}

#Preview {
    TestView4(currentView: .constant(4))
}
