//
//  ReviewCardView.swift
//  training
//

import SwiftUI

struct ReviewCardView: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle()
                    .fill(.purple.gradient)
                    .frame(width: 36, height: 36)
                    .overlay {
                        Text(review.author.prefix(1))
                            .foregroundStyle(.white)
                            .font(.subheadline.bold())
                    }
                VStack(alignment: .leading) {
                    Text(review.author)
                        .font(.subheadline.bold())
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < review.rating ? "star.fill" : "star")
                                .font(.caption2)
                                .foregroundStyle(.blue)
                        }
                        Text(review.date)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
            }

            Text(review.comment)
                .font(.subheadline)

            Text("\(review.helpfulCount) people found this helpful")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ReviewCardView(review: Review(
        author: "Daniel M",
        rating: 1,
        date: "7/21/26",
        comment: "Be cautious! Many prices are displayed incorrectly and increase at checkout.",
        helpfulCount: 38
    ))
    .padding()
}
