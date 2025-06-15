//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct TestView2: View {
    @Binding var currentView: Int
    @State private var boubaChoice: String? = nil
    @State private var kikiChoice: String? = nil
    @State private var showResult = false
    @State private var showShapes = false
    @State private var showOptions1 = false
    @State private var showShape2 = false
    @State private var showOptions2 = false

    var correctChoice: Bool {
        return boubaChoice == "Bouba" && kikiChoice == "Kiki"
    }

    var allMatched: Bool {
        return boubaChoice != nil && kikiChoice != nil
    }

    var availableOptions: [String] {
        let used = [boubaChoice, kikiChoice].compactMap { $0 }
        return ["Bouba", "Kiki"].filter { !used.contains($0) }
    }

    var body: some View {
        Spacer().frame(height: 40)
        VStack {
            if !showResult {
                Text("What name would you **assign** to these shapes?")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(showShapes ? 1 : 0)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.8)) {
                            showShapes = true
                        }
                    }

                Spacer().frame(height: 40)

                VStack(spacing: 50) {
                    if showShapes {
                        FormSelectionView(symbol: "🟡", selectedOption: $boubaChoice, availableOptions: availableOptions, onSelection: { choice in
                            boubaChoice = choice
                            if kikiChoice == choice { kikiChoice = nil }
                        })
                        .opacity(showOptions1 ? 1 : 0)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.8).delay(1)) {
                                showOptions1 = true
                            }
                        }
                    }

                    if showOptions1 {
                        FormSelectionView(symbol: "🔺", selectedOption: $kikiChoice, availableOptions: availableOptions, onSelection: { choice in
                            kikiChoice = choice
                            if boubaChoice == choice { boubaChoice = nil }
                        })
                        .opacity(showOptions2 ? 1 : 0)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.8).delay(2.2)) {
                                showOptions2 = true
                            }
                        }
                    }
                }

                .padding(.bottom, 90)

                if allMatched {
                    Button(action: { withAnimation { showResult = true } }) {
                        Text("Confirm")
                            .font(.title2)
                            .padding()
                            .frame(width: 200)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                            .opacity(showOptions2 ? 1 : 0)
                    }
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.8).delay(0.3)) {
                            showOptions2 = true
                        }
                    }
                }

                
            } else {
                TestResultView(correctChoice: correctChoice, onContinue: { currentView += 1 })
            }
        }
    }
}


// Selection of shape
struct FormSelectionView: View {
    let symbol: String
    @Binding var selectedOption: String?
    let availableOptions: [String]
    let onSelection: (String) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(symbol)
                .font(.system(size: 100))

            HStack(spacing: 20) {
                ForEach(["Bouba", "Kiki"], id: \.self) { option in
                    OptionButton(
                        title: option,
                        isSelected: selectedOption == option,
                        isDisabled: !availableOptions.contains(option),
                        action: { onSelection(option) }
                    )
                }
            }
        }
    }
}

// Button for options
struct OptionButton: View {
    let title: String
    let isSelected: Bool
    let isDisabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title2)
                .padding()
                .frame(width: 100)
                .background(isSelected ? Color.blue : Color.gray.opacity(isDisabled ? 0.3 : 0.6))
                .foregroundColor(.white)
                .cornerRadius(10)
                .opacity(isDisabled ? 0.5 : 1.0)
        }
        .disabled(isDisabled)
    }
}

#Preview {
    TestView2(currentView: .constant(4))
}
