//
//  DetailView.swift
//  training
//

import SwiftUI

struct DetailView: View {
    let name: String

    private let ratingDistribution: [(stars: Int, fraction: CGFloat)] = [
        (5, 0.78),
        (4, 0.10),
        (3, 0.05),
        (2, 0.03),
        (1, 0.04)
    ]

    private let reviews: [Review] = [
        Review(
            author: "Daniel M",
            rating: 1,
            date: "7/21/26",
            comment: "Be cautious! Many prices are displayed incorrectly and increase at checkout. It's NOT because of the shipping cost. The prices are incorrect on the first...",
            helpfulCount: 38
        ),
        Review(
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
                AppHeaderView(name: name)
                installButton
                ScreenshotsView()
                AboutAppView()
                Divider()
                RatingsAndReviewsView(ratingDistribution: ratingDistribution, reviews: reviews)
            }
            .padding()
//            .background(Color.red)
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var installButton: some View {
        Button("Install") {
        }
        .buttonStyle(.borderedProminent)
        .frame(maxWidth: .infinity)
        .controlSize(.large)
    }
}

#Preview {
    NavigationStack {
        DetailView(name: "Jane")
    }
}
