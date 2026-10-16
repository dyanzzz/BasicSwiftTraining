//
//  CounterView.swift
//  training
//

import SwiftUI

struct CounterView: View {
    @State private var count = 0

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("\(count)")
                    .font(.system(size: 60, weight: .bold))

                HStack(spacing: 24) {
                    Button {
                        count -= 1
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .font(.largeTitle)
                    }

                    Button {
                        count += 1
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                    }
                }
            }
            .navigationTitle("Counter")
        }
    }
}

#Preview {
    CounterView()
}
