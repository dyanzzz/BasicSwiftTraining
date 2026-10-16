//
//  MainView.swift
//  training
//
//  Created by dev on 13/10/26.
//

import SwiftUI

struct MainView: View {
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

            ContentView()
                        .tabItem {
                            Label("Hello", systemImage: "hand.wave")
                        }
                        .tag(2)
                }
    }
}

#Preview {
    MainView()
}
