//  Created by @dardarius aka Dario Saldamarco

import SwiftUI

struct ContentView: View {
    @State private var selectedShape: String = ""
    @State private var currentView = 0
    @State private var userName: String = ""
    @State private var associations: [String: Color] = [:]
    
    let soundPatterns = [
        "Soft waves", "Syncopated rhythms", "Ethereal tones", "Gentle chimes", "Pulsating echoes",
        "Whispering hums", "Bubbling harmonics", "Floating whispers", "Velvet drones", "Dreamy oscillations"
    ]
    
    let shapeNames = [
        "Fluid Balloon", "Soft Cloud", "Wavy Orb", "Melting Circle", "Floating Bubble",
        "Liquid Coil", "Puffy Swirl", "Bouncy Drop", "Rolling Wave", "Misty Halo",
        "Fuzzy Loop", "Drifting Sphere", "Jellybean Curve", "Velvet Ripple", "Blobby Curl",
        "Elastic Ovoid", "Dreamy Puff", "Glowing Amoeba", "Ghostly Swirl", "Hazy Droplet"
    ]
    
    var body: some View {
        ZStack {
            if currentView == 0 {
                StartView(currentView: $currentView)
            } else if currentView == 1 {
                AnimationView(currentView: $currentView)
            } else if currentView == 2 {
                TestView(currentView: $currentView, associations: $associations)
            } else if currentView == 3 {
                TestView3(currentView: $currentView)
            } else if currentView == 4 {
                TestView4(currentView: $currentView)
            } else if currentView == 5 {
                TestView2(currentView: $currentView)
            } else if currentView == 6 {
                NameInputView(currentView: $currentView, userName: $userName)
            } else if currentView == 7 {
                NameShapeView(
                    currentView: $currentView,
                    userName: userName,
                    selectedColors: Array(associations.values),
                    selectedShape: $selectedShape)
            } else if currentView == 8 {
                SynestheticResultsView(
                    currentView: $currentView,
                    userName: $userName,
                    associations: $associations,
                    dominantColors: Array(associations.values),
                    soundPatterns: soundPatterns.shuffled().prefix(3).map { $0 },
                    shapeType: selectedShape)
            }
            else {
                SynestheticExperiencesView(currentView: $currentView,
                                           associations: $associations)
            }
        }
    }
}
