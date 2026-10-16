//
//  Welcome.swift
//  training
//

import SwiftUI

struct WelcomeView: View {
    let name: String
    let selectedStudent: String
    @State private var showingProfile = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome, \(name)!")
                .font(.title)
            Text("Student of \(selectedStudent)")
                .foregroundStyle(.secondary)

            Button("View Profile") {
                showingProfile = true
            }
            .buttonStyle(.borderedProminent)

            NavigationLink("Show Map") {
                MapView(name: name)
            }
            .buttonStyle(.bordered)
            
            NavigationLink("Detail Profile") {
                DetailProfile(name: name)
            }
            .buttonStyle(.bordered)
            
            NavigationLink("Learn photo calendar") {
                PhotoCalendarView()
            }
            .buttonStyle(.bordered)
            
            NavigationLink("Web Detail View") {
                WebDetailView()
            }
            .buttonStyle(.bordered)
        }
        .sheet(isPresented: $showingProfile) {
            ProfileView(name: name)
        }
    }
}

#Preview {
    WelcomeView(name: "Jane", selectedStudent: "Harry")
}
