//
//  BannerAd.swift
//  Othelloo
//
//  Created by juandahurt on 22/02/21.
//

import SwiftUI
import GoogleMobileAds

final private class BannerVC: UIViewControllerRepresentable  {
    private let testBannerId = "ca-app-pub-3940256099942544/6300978111"
    private let bannerId = "ca-app-pub-3880886608489890/3311566572"
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)

        let viewController = UIViewController()
        view.adUnitID = testBannerId
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct BannerAd: View {
    var body: some View {
        BannerVC().frame(maxWidth: .infinity)
    }
}
