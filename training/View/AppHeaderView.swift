//
//  AppHeaderView.swift
//  training
//

import SwiftUI

struct AppHeaderView: View {
    let name: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            RoundedRectangle(cornerRadius: 22)
                .fill(.orange.gradient)
                .frame(width: 80, height: 80)
                .overlay {
                    Image(systemName: "bag.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text("\(name)'s App")
                    .font(.title2.bold())
                Text("Dummy Developer Inc.")
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                Text("In-app purchases")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .overlay(alignment: .bottom) {
            HStack(spacing: 0) {
                statItem(value: "4.5★", label: "18M reviews")
                statDivider
                statItem(value: "3+", label: "Rated for 3+")
                statDivider
                statItem(value: "110 MB", label: "")
                statDivider
                statItem(value: "100M", label: "Downloads")
            }
            .offset(y: 56)
        }
        .padding(.bottom, 56)
    }

    private var statDivider: some View {
        Rectangle()
            .fill(.secondary.opacity(0.3))
            .frame(width: 1, height: 36)
    }

    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.subheadline.bold())
            if !label.isEmpty {
                Text(label)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AppHeaderView(name: "Jane")
        .padding()
}
