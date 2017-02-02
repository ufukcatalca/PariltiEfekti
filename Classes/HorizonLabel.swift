//
//  HorizonLabel.swift
//  PariltiEfekti
//
//  Left To Right
//  Created by ufuk çatalca on 01/02/2017.
//  Copyright © 2017 parilti. All rights reserved.
//

/*
 CGColor: A set of components that define a color, with a color space specifying how to interpret them.
 */

// Temel mantık uygulamada ekranda bir label yani bir yazı var yazının saydamlıgını azaltıp bir başlangıç ve bitiş noktaları verip bir gradyanı yazının üstünde soldan saga dogru kaydırma işlemi.

import UIKit

class HorizonLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.efektEkle();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.efektEkle()
    }
    
    func efektEkle() { // bir fonksiyon oluşturduk.
        
        let labelSaydamligi :CGFloat = 0.1  // label'ın saydamlıgını ayarla
        let labelGenislik:CGFloat = self.frame.size.width //labelin genişligini bul
        
        let pariltiUzunluk :CGFloat = 40 / labelGenislik  // 40 sayısının label'ın genişligine böldügümüz de parıltı efektinin uzunlugunu buluruz.
        
        let baslangicLokasyonu :NSArray = [NSNumber.init(value: 0.0 as Float), NSNumber.init(value: ((Float)(pariltiUzunluk / 2)) as Float),NSNumber.init(value: ((Float)(pariltiUzunluk)/1) as Float)] //başlangıç degerlerini dizide tutuyoruz.
        
        let bitisLokasyonu = [(1.0 - pariltiUzunluk), (1.0 - (pariltiUzunluk / 2)), 1.0] as NSArray // bitil noktalarınıda dizi de tutuyoruz.tabiki başlangıç ve bitiş label'ımızın uzunluguna göre oluyor
        
        let animasyon :CABasicAnimation = CABasicAnimation(keyPath: "locations")
        let pariltiMaskeleme:CAGradientLayer = CAGradientLayer.init()
        pariltiMaskeleme.frame = self.bounds // sınırlar
        
        // **Partılı efektinin özellikleri**
        let gradient = UIColor.init(white: 0.5, alpha: labelSaydamligi)
        pariltiMaskeleme.colors =  [gradient.cgColor,UIColor.white.cgColor,gradient.cgColor] // rengi
        pariltiMaskeleme.locations = baslangicLokasyonu as? [NSNumber] // lokasyonlar dizi de belirlenen noktalar
        pariltiMaskeleme.startPoint = CGPoint(x: 0 - (pariltiUzunluk * 2), y: 1) // başladı
        pariltiMaskeleme.endPoint = CGPoint(x: 1 + pariltiUzunluk , y: 1) // bitti
        self.layer.mask = pariltiMaskeleme
        
        animasyon.fromValue = baslangicLokasyonu // bu noktalarda başla
        animasyon.toValue = bitisLokasyonu     // bu noktalarda bitir
        animasyon.repeatCount = Float.infinity //kaç kere bu işlemi yapıcak : sonuz kere
        animasyon.duration = 1.5 // bu işlem ne kadar süre içinde tamamlanacak saniye cinsinden
        pariltiMaskeleme.add(animasyon, forKey: "gradientAnimation")
    }
}






