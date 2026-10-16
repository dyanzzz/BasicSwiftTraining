//
//  HomeView.swift
//  training
//

import SwiftUI

struct HomeView: View {
    @Bindable private var router = Router.shared

    @State private var name = ""
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    var body: some View {
        NavigationStack(path: $router.homePath) {
            Form {
                Section {
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(students, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextField("Enter your name", text: $name)
                    Text("Your name is \(name)")
                }

                Section {
                    NavigationLink("Go to second page") {
                        WelcomeView(name: name, selectedStudent: selectedStudent)
                    }
                }
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .photoCalendar:
                    PhotoCalendarView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
