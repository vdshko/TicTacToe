//
//  AnyCancellable+CancelBag.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 07.06.2022.
//

import Combine

extension AnyCancellable {
    
    func store(in bag: CancelBag) {
        if bag.contains(self) {
            return
        }
        
        bag.insert(self)
    }
}
