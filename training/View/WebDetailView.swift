//
//  WebDetailView.swift
//  training
//

import SwiftUI
import WebKit
import UIKit
import UserNotifications

struct WebContentView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
}

struct WebDetailView: View {
    private let url = URL(string: "https://www.apple.com")!

    var body: some View {
        VStack(spacing: 16) {
            WebContentView(url: url)

            Button("Local Notification") {
                scheduleLocalNotification()
            }
            .buttonStyle(.borderedProminent)

            Button("Push Notification") {
                registerForPushNotifications()
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle("Web Detail")
    }

    private func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test"
        content.body = "Halo"
        content.sound = .default
        content.userInfo = ["route": "photoCalendar"]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            guard granted else { return }
            UNUserNotificationCenter.current().add(request)
        }
    }

    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}

#Preview {
    NavigationStack {
        WebDetailView()
    }
}
