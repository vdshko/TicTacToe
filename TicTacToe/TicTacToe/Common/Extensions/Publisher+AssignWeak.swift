//
//  Publisher+AssignWeak.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 07.06.2022.
//

import Combine

extension Publisher where Self.Failure == Never {
    
    func assignWeak<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable {
        return sink { [weak object] (value: Self.Output) in
            object?[keyPath: keyPath] = value
        }
    }
}
