//
//  DetailView.swift
//  training
//

import SwiftUI

private struct DummyReview: Identifiable {
    let id = UUID()
    let author: String
    let rating: Int
    let date: String
    let comment: String
    let helpfulCount: Int
}

struct DetailProfile: View {
    let name: String

    private let ratingDistribution: [(stars: Int, fraction: CGFloat)] = [
        (5, 0.78),
        (4, 0.10),
        (3, 0.05),
        (2, 0.03),
        (1, 0.04)
    ]

    private let reviews: [DummyReview] = [
        DummyReview(
            author: "Daniel M",
            rating: 1,
            date: "7/21/26",
            comment: "Be cautious! Many prices are displayed incorrectly and increase at checkout. It's NOT because of the shipping cost. The prices are incorrect on the first...",
            helpfulCount: 38
        ),
        DummyReview(
            author: "Roshalyn Azzara",
            rating: 1,
            date: "8/4/26",
            comment: "I feel that the app has become increasingly stingy with promos compared to before.",
            helpfulCount: 12
        )
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                installButton
                screenshots
                aboutSection
                Divider()
                ratingsAndReviews
            }
            .padding()
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
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

    private var installButton: some View {
        Button("Install") {
        }
        .buttonStyle(.borderedProminent)
        .frame(maxWidth: .infinity)
        .controlSize(.large)
    }

    private var screenshots: some View {
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

    private var aboutSection: some View {
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

    private var ratingsAndReviews: some View {
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
                reviewCard(review)
            }
        }
    }

    private func reviewCard(_ review: DummyReview) -> some View {
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
    NavigationStack {
        DetailProfile(name: "Jane")
    }
}
