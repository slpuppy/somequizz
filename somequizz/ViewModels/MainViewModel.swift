//
//  MainViewModel.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

class MainViewModel: ObservableObject {

    @Published var screenData: MainScreenData?
    @Published var isLoading: Bool = true

    private let service: MainContentServiceProtocol

    init(service: MainContentServiceProtocol = FirestoreMainContentService()) {
        self.service = service
        Task { await loadContent() }
    }

    @MainActor
    private func loadContent() async {
        do {
            let content = try await service.fetchContent()
            screenData = mapToScreenData(from: content)
        } catch {
            print("[MainViewModel] Firestore fetch failed: \(error)")
            screenData = mapToScreenData(from: nil)
        }
        isLoading = false
    }

    // MARK: - Private

    private func mapToScreenData(from content: ScreenContent?) -> MainScreenData {
        MainScreenData(
            title: content?.title ?? localizeString("main.title"),
            subtitle: content?.subtitle ?? localizeString("main.subtitle"),
            lockedSubtitle: content?.label1 ?? localizeString("main.locked_subtitle"),
            startButton: content?.buttons?.first?.title ?? localizeString("main.start_button"),
            lockedButton: content?.buttons?.last?.title ?? localizeString("main.come_back_tomorrow")
        )
    }
}
