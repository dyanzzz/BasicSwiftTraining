//
//  AboutAppView.swift
//  training
//

import SwiftUI

struct AboutAppView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("About this app")
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            Text("Enjoy dummy features and placeholder vouchers in this sample detail screen.")
                .font(.title3)

            HStack(spacing: 8) {
                tag("#1 top free in shopping")
                tag("Online marketplace")
            }
        }
    }

    private func tag(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .overlay(
                Capsule().stroke(.secondary.opacity(0.4))
            )
    }
}

#Preview {
    AboutAppView()
        .padding()
}
