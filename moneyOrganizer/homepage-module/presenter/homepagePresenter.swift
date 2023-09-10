//
//  homepagePresenter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 6.09.2023.
//

import Foundation
import UIKit

class homepagePresenter : ViewToPresenterHomepageProtocol {
    
    var homepageView: PresenterToViewHomepageProtocol?
    var homepageInteractor: PresenterToInteractorHomepageProtocol?
    
    func readAccountsFile() {
        homepageInteractor?.readAccounts()
    }
    
}


extension homepagePresenter : InteractorToPresenterHomepageProtocol {
    
    func sendDataPresentar(accountList: Array<accounts>) {
        homepageView?.sendDataView(accountList: accountList)
    }
    
}

class BarChartView: UIView {
    
        let valuesSet1: [CGFloat] = [30, 45, 60, 30, 90, 55, 30]
        let valuesSet2: [CGFloat] = [20, 35, 70, 15, 80, 45, 65]
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            let barWidth: CGFloat = 20
            let spacing: CGFloat = (rect.width - 140) / 7
            let maxValue1 = valuesSet1.max() ?? 0.0
            let maxValue2 = valuesSet2.max() ?? 0.0
          
            let maxValue:CGFloat
            let scale1:CGFloat
            let scale2:CGFloat
            
            if maxValue1 > maxValue2 {
                maxValue = maxValue1
            } else {
                maxValue = maxValue2
            }
            
            scale1 = rect.height / maxValue
            scale2 = rect.height / maxValue
            
            for (index, (value1, value2)) in zip(valuesSet1, valuesSet2).enumerated() {
                let x = CGFloat(index) * (barWidth + spacing)
                let x2 = CGFloat(index) * (barWidth + spacing) + 12
                let barHeight1 = value1 * scale1
                let barHeight2 = value2 * scale2
                let y1 = rect.height - barHeight1
                let y2 = rect.height - barHeight2
                
                let barColor1 = UIColor(hex: "DBFF00")
                let barColor2 = UIColor(hex: "2F2F2F")
                
                let barRect1 = CGRect(x: x, y: y1, width: barWidth, height: barHeight1)
                context.setFillColor(barColor1.cgColor)
                context.fill(barRect1)

                let barRect2 = CGRect(x: x2, y: y2, width: barWidth, height: barHeight2)
                context.setFillColor(barColor2.cgColor)
                context.fill(barRect2)
                
            }
        }
    }


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
