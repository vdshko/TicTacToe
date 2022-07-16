//
//  AppDelegate.swift
//  TicTacToe
//
//  Created by Vlad Shkodich on 15.07.2022.
//

import UIKit
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
        
    static var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

extension View {
    
    func unlockRotation() -> some View {
        onAppear {
            AppDelegate.orientationLock = UIInterfaceOrientationMask.all
            UIViewController.attemptRotationToDeviceOrientation()
        }
        .onDisappear {
            AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
}
