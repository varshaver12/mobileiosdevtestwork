//
//  SceneDelegate.swift
//  mobileiosdevtestwork
//
//  Created by Aleksey Khlestkin on 13.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let viewModel = DealsScreenViewModel()
        let rootVC = DealsScreenView(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: rootVC)
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }


}

