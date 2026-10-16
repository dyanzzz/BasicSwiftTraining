//
//  ScreenshotsView.swift
//  training
//

import SwiftUI

struct ScreenshotsView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(0..<3) { index in
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.orange.opacity(0.8))
                        .frame(width: 160, height: 300)
                        .overlay {
                            Text("Screenshot \(index + 1)")
                                .foregroundStyle(.white)
                                .font(.headline)
                        }
                }
            }
        }
    }
}

#Preview {
    ScreenshotsView()
        .padding()
}
