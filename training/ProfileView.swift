//
//  ProfileView.swift
//  training
//

import SwiftUI

struct ProfileView: View {
    let name: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 8) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .foregroundStyle(.secondary)
                        Text(name)
                            .font(.title2.bold())
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
                .listRowBackground(Color.clear)

                Section {
                    NavigationLink(destination: Text("Activity Status")) {
                        HStack {
                            Image(systemName: "bolt.fill")
                                .foregroundStyle(.orange)
                            Text("Activity Status")
                            Spacer()
                            Circle()
                                .fill(.green)
                                .frame(width: 8, height: 8)
                            Text("Active")
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("PERSONALIZE") {
                    NavigationLink(destination: Text("Personal Details")) {
                        Label("Personal Details", systemImage: "person.fill")
                    }
                    NavigationLink(destination: Text("Heart Rate Zones")) {
                        Label("Heart Rate Zones", systemImage: "heart.text.square")
                    }
                }

                Section {
                    NavigationLink(destination: Text("Settings")) {
                        Label("Settings", systemImage: "gearshape")
                    }
                }

                Section("NEED HELP?") {
                    NavigationLink(destination: Text("Tips and Tricks")) {
                        Label("Tips and Tricks", systemImage: "hand.tap")
                    }
                    NavigationLink(destination: Text("Frequently Asked Questions")) {
                        Label("Frequently Asked Questions", systemImage: "questionmark.circle")
                    }
                    NavigationLink(destination: Text("Contact Us")) {
                        Label("Contact Us", systemImage: "envelope")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView(name: "Omar")
}
