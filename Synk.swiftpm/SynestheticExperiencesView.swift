//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct SynestheticExperiencesView: View {
    @Binding var currentView: Int
    @Binding var associations: [String: Color]

    let buttonData: [(String, Color, String, AnyView)] = [
        ("Smooth", .blue, "smooth_texture", AnyView(SmoothView())),
        ("Rough", .red, "rough_texture", AnyView(RoughView())),
        ("Bumpy", .green, "bumpy_texture", AnyView(BumpyView())),
        ("Sharp", .orange, "sharp_texture", AnyView(SharpView())),
        ("Soft", .purple, "soft_texture", AnyView(SoftView()))
    ]
    
    @State private var pressedButtonIndex: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Synesthetic Surfaces")
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                // Griglia 2x2
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
                    ForEach(0..<4, id: \ .self) { index in
                        NavigationLink(destination: buttonData[index].3) {
                            createHapticButton(index: index)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .zIndex(1) // 🔹 Priority
                .padding(.horizontal, 30)
                
                //
                NavigationLink(destination: buttonData[4].3) {
                    createHapticButton(index: 4)
                        .frame(width: 250, height: 130)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                // Button "Take the test again"
                NavigationLink(destination: TestView(currentView: $currentView, associations: $associations)) {
                    Text("Take the test again")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 250, height: 80)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(30)
                        .shadow(radius: 5)
                }
                Spacer()
            }
            .background(Color(.systemBackground))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func createHapticButton(index: Int) -> some View {
        let (title, _, texture, _) = buttonData[index]
        
        return ZStack {
            Image(texture)
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(Color.black.opacity(0.2))
            
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .shadow(radius: 5)
        }
        .frame(height: 140)
        .cornerRadius(20)
        .scaleEffect(pressedButtonIndex == index ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: pressedButtonIndex)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in pressedButtonIndex = index }
                .onEnded { _ in pressedButtonIndex = nil }
        )
    }
}

// Preview 
struct SynestheticExperiencesView_Previews: PreviewProvider {
    static var previews: some View {
        SynestheticExperiencesView(
            currentView: .constant(0),
            associations: .constant(["Smooth": .blue, "Rough": .red])
        )
    }
}
