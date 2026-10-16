//
//  Router.swift
//  training
//

import Observation

enum AppRoute: Hashable {
    case photoCalendar
}

@MainActor
@Observable
final class Router {
    static let shared = Router()

    var selectedTab: Int = 0
    var homePath: [AppRoute] = []

    private init() {}

    func goToPhotoCalendar() {
        selectedTab = 0
        homePath = [.photoCalendar]
    }
}
