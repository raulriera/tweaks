//
//  StorageObserver.swift
//  Tweaks
//
//  Created by Raul Riera on 2026-01-14.
//


@Observable
class StorageObserver {
    var updateTrigger = 0
    let key: String
    let store: UserDefaults
    private var cancellable: AnyCancellable?
    
    init(key: String, store: UserDefaults) {
        self.key = key
        self.store = store
        
        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .filter { notification in
                guard let defaults = notification.object as? UserDefaults else { return false }
                return defaults === store
            }
            .sink { [weak self] _ in
                self?.updateTrigger += 1
            }
    }
}