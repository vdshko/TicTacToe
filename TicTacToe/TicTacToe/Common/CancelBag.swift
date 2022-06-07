//
//  CancelBag.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 07.06.2022.
//

import Combine
import class Foundation.NSLock

final class CancelBag {
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    private let lock: NSLock = NSLock()
    
    deinit {
        cancelAll()
    }
    
    func insert(_ cancellable: AnyCancellable) {
        lock.lock()
        defer {
            lock.unlock()
        }
        subscriptions.insert(cancellable)
    }
    
    func contains(_ cancellable: AnyCancellable) -> Bool {
        lock.lock()
        defer {
            lock.unlock()
        }
        return subscriptions.contains(cancellable)
    }
    
    func contains(where predicate: (AnyCancellable) throws -> Bool) rethrows -> Bool {
        lock.lock()
        defer {
            lock.unlock()
        }
        return try subscriptions.contains(where: predicate)
    }
    
    func cancel(_ cancellable: AnyCancellable) {
        lock.lock()
        defer {
            lock.unlock()
        }
        subscriptions.remove(cancellable)
    }
    
    func cancelAll() {
        lock.lock()
        defer {
            lock.unlock()
        }
        subscriptions.removeAll()
    }
}
