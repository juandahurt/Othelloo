//
//  AdView.swift
//  Othelloo
//
//  Created by juandahurt on 19/02/21.
//

import GoogleMobileAds
import UIKit


final class Interstitial:NSObject, GADInterstitialDelegate{
    static private let testIntersitialID = "ca-app-pub-3940256099942544/1033173712"
    static private let interstitialID = "ca-app-pub-3880886608489890/2058178740"
    var interstitial: GADInterstitial = GADInterstitial(adUnitID: testIntersitialID)
    
    override init() {
        super.init()
        LoadInterstitial()
    }
    
    func LoadInterstitial(){
        let req = GADRequest()
        self.interstitial.load(req)
        self.interstitial.delegate = self
    }
    
    func showAd(){
        if self.interstitial.isReady{
           let root = UIApplication.shared.windows.first?.rootViewController
           self.interstitial.present(fromRootViewController: root!)
        }
       else{
           print("Not Ready")
       }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = GADInterstitial(adUnitID: Self.testIntersitialID)
        LoadInterstitial()
    }
}
