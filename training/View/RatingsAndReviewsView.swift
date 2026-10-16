//
//  RatingsAndReviewsView.swift
//  training
//

import SwiftUI

struct RatingsAndReviewsView: View {
    let ratingDistribution: [(stars: Int, fraction: CGFloat)]
    let reviews: [Review]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Ratings and reviews")
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }

            Text("Ratings and reviews are verified and are from people who use the same type of device that you use")
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack(alignment: .center, spacing: 20) {
                VStack {
                    Text("4.5")
                        .font(.system(size: 44, weight: .bold))
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < 4 ? "star.fill" : "star.leadinghalf.filled")
                                .foregroundStyle(.blue)
                                .font(.caption)
                        }
                    }
                    Text("18,565,655")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                VStack(spacing: 6) {
                    ForEach(ratingDistribution, id: \.stars) { item in
                        HStack(spacing: 8) {
                            Text("\(item.stars)")
                                .font(.caption2)
                                .frame(width: 10)
                            GeometryReader { geometry in
                                Capsule()
                                    .fill(.secondary.opacity(0.2))
                                    .overlay(alignment: .leading) {
                                        Capsule()
                                            .fill(.blue)
                                            .frame(width: geometry.size.width * item.fraction)
                                    }
                            }
                            .frame(height: 6)
                        }
                    }
                }
            }

            ForEach(reviews) { review in
                ReviewCardView(review: review)
            }
        }
    }
}

#Preview {
    RatingsAndReviewsView(
        ratingDistribution: [(5, 0.78), (4, 0.10), (3, 0.05), (2, 0.03), (1, 0.04)],
        reviews: [
            Review(author: "Daniel M", rating: 1, date: "7/21/26", comment: "Be cautious! Many prices are displayed incorrectly.", helpfulCount: 38)
        ]
    )
    .padding()
}
