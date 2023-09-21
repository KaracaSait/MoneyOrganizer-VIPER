//
//  homepagePresenter.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 6.09.2023.
//

import Foundation
import UIKit

var moneyPlusBar = [CGFloat]()
var moneyMinusBar = [CGFloat]()
var callCount = 0
var days = [String]()

class homepagePresenter : ViewToPresenterHomepageProtocol {
    
    var homepageView: PresenterToViewHomepageProtocol?
    var homepageInteractor: PresenterToInteractorHomepageProtocol?
    
    func readAccountsFile() {
        homepageInteractor?.readAccounts()
    }
    
    func dataRead() {
        homepageInteractor?.accountDataRead()
    }
    
    func readAccountDetailFile() {
        homepageInteractor?.readAccountDetail()
    }
    
    func readBarChart() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "dd/MM"
        let today = formatter.string(from: Date())
        let todayBC = formatterDay.string(from: Date())
        
        let dateValues = [
            Calendar.current.date(byAdding: .day, value: -6, to: Date()),
            Calendar.current.date(byAdding: .day, value: -5, to: Date()),
            Calendar.current.date(byAdding: .day, value: -4, to: Date()),
            Calendar.current.date(byAdding: .day, value: -3, to: Date()),
            Calendar.current.date(byAdding: .day, value: -2, to: Date()),
            Calendar.current.date(byAdding: .day, value: -1, to: Date())
        ]
        
        for dateValue in dateValues {
            if let date = dateValue {
                let dateString = formatter.string(from: date)
                homepageInteractor?.readBarChartDetail(day: dateString)
                let dateStringBC = formatterDay.string(from: date)
                days.append(dateStringBC)
            }
        }
        homepageInteractor?.readBarChartDetail(day: today)
        days.append(todayBC)
    }
    
}

extension homepagePresenter : InteractorToPresenterHomepageProtocol {
    
    func sendDataPresentar(accountList: Array<accounts>) {
        homepageView?.sendDataView(accountList: accountList)
    }
    func sendBankAccountDetailPresentar(accountDetail: Array<accountDetail>) {
        homepageView?.sendBankAccountDetailView(accountDetail: accountDetail)
    }
    func sendCashAccountDetailPresentar(accountDetail: Array<accountDetail>) {
        homepageView?.sendCashAccountDetailView(accountDetail: accountDetail)
    }
    func sendCreditAccountDetailPresentar(accountDetail: Array<accountDetail>) {
        homepageView?.sendCreditAccountDetailView(accountDetail: accountDetail)
    }
    func sendTotalMoneyBankPresentar(totalMoney: Int) {
        homepageView?.sendTotalMoneyBankView(totalMoney: totalMoney)
    }
    func sendTotalMoneyCashPresentar(totalMoney: Int) {
        homepageView?.sendTotalMoneyCashView(totalMoney: totalMoney)
    }
    func sendTotalMoneyCreditPresentar(totalMoney: Int) {
        homepageView?.sendTotalMoneyCreditView(totalMoney: totalMoney)
    }
    func sendBarChartDetailPresentar(moneyPlus:Int, moneyMinus:Int) {
        if callCount % 7 == 0 {
                moneyPlusBar = []
                moneyMinusBar = []
            }
        callCount += 1
        moneyPlusBar.append(CGFloat(moneyPlus))
        moneyMinusBar.append(CGFloat(moneyMinus))
    }

}

class BarChartView: UIView {
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            let barWidth: CGFloat = 20
            let spacing: CGFloat = (rect.width - 140) / 7
            let maxValue1 = moneyPlusBar.max() ?? 0.0
            let maxValue2 = moneyMinusBar.max() ?? 0.0
          
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
            
            for (index, (value1, value2)) in zip(moneyPlusBar, moneyMinusBar).enumerated() {
                let x = CGFloat(index) * (barWidth + spacing)
                let x2 = CGFloat(index) * (barWidth + spacing) + 12
                let barHeight1 = value1 * scale1
                let barHeight2 = value2 * scale2
                let y1 = rect.height - barHeight1 - 15
                let y2 = rect.height - barHeight2 - 15
                
                let barColor1 = UIColor(named: "barColor1")
                let barColor2 = UIColor(named: "barColor2")
                
                let barRect1 = CGRect(x: x, y: y1, width: barWidth, height: barHeight1)
                context.setFillColor(barColor1!.cgColor)
                context.fill(barRect1)

                let barRect2 = CGRect(x: x2, y: y2, width: barWidth, height: barHeight2)
                context.setFillColor(barColor2!.cgColor)
                context.fill(barRect2)
                
                let label = days[index]
                let labelRect = CGRect(x: x + 8, y: rect.height - 10, width: barWidth, height: 10)
                let textAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 6),
                    .foregroundColor: UIColor.black
                ]
                let attributedText = NSAttributedString(string: label, attributes: textAttributes)
                attributedText.draw(in: labelRect)
            }
        }
    }
