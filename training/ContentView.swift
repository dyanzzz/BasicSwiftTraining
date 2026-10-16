//
//  ContentView.swift
//  training
//
//  Created by Ardian Franindo on 08/10/26.
//

import SwiftUI

struct ContentView: View {
    @Bindable private var router = Router.shared

    var body: some View {
        TabView(selection: $router.selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            CounterView()
                .tabItem {
                    Label("Counter", systemImage: "plus.slash.minus")
                }
                .tag(1)

            HelloWorldView()
                .tabItem {
                    Label("Hello", systemImage: "hand.wave")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
