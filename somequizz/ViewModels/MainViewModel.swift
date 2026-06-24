//
//  MainViewModel.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

class MainViewModel: ObservableObject {

    @Published var content: ScreenContent?
    @Published var isLoading: Bool = true

    private let service: MainContentServiceProtocol

    init(service: MainContentServiceProtocol = FirestoreMainContentService()) {
        self.service = service
        Task { await loadContent() }
    }

    @MainActor
    private func loadContent() async {
        do {
            content = try await service.fetchContent()
        } catch {
            print("[MainViewModel] Firestore fetch failed: \(error)")
        }
        isLoading = false
    }

    var title: String       { content?.title            ?? localizeString("main.title") }
    var subtitle: String    { content?.subtitle         ?? localizeString("main.subtitle") }
    var startButton: String { content?.buttons?.first?.title ?? localizeString("main.start_button") }
}
