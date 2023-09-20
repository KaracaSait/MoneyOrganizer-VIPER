//
//  ViewController.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 6.09.2023.
//

import UIKit

class homepageViewController: UIViewController {
    
    var presenterObject : ViewToPresenterHomepageProtocol?
    
    @IBOutlet weak var homepageTableView: UITableView!
    @IBOutlet weak var graphicView: BarChartView!
    @IBOutlet weak var graphicBackground: UIImageView!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var exchangeRateButtonImage: UIButton!
    
    @IBOutlet weak var incomeImage: UIImageView!
    @IBOutlet weak var expenseImage: UIImageView!
    
    var AccountList = [accounts]()
    
    var bankAccount = [accountDetail]()
    var cashAccount = [accountDetail]()
    var creditAccount = [accountDetail]()
    
    var bankAccountMoney:String?
    var cashAccountMoney:String?
    var creditAccountMoney:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homepageRouter.createModule(ref: self)
        
        homepageTableView.dataSource = self
        homepageTableView.delegate = self
        
        incomeImage.backgroundColor = UIColor(named: "barColor1")
        expenseImage.backgroundColor = UIColor(named: "barColor2")
        
        graphicView.backgroundColor = .clear
        graphicBackground.image = UIImage(named: "graphicBackground")
        
        exchangeRateButtonImage.setTitle("", for: .normal)
        exchangeRateButtonImage.setImage(UIImage(named: "exchangeRateIcon"), for: .normal)
        exchangeRateButtonImage.setImage(UIImage(named: "exchangeRateIconPush"), for: .highlighted)
        view.addSubview(exchangeRateButtonImage)
        
        helloLabel.text = "Hello, King!"
        
        veritabaniKopyala()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        presenterObject?.readAccountsFile()
        presenterObject?.dataRead()
        presenterObject?.readAccountDetailFile()
        presenterObject?.readBarChart()
        if let barChartView = self.graphicView {
            barChartView.setNeedsDisplay()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homepageToDetail" {
            let index = sender as? Int
            let targetVC = segue.destination as! detailViewController
            targetVC.whichAccount = AccountList[index!]
        }
    }
    
    @IBAction func exchangeRateButton(_ sender: Any) {
        performSegue(withIdentifier: "toExchangeRate", sender: nil)
    }
    
    func veritabaniKopyala() {
        let bundleYolu = Bundle.main.path(forResource: "wallet", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("wallet.sqlite")
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten var")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{}
        }
    }
    
}

extension homepageViewController: PresenterToViewHomepageProtocol {
    
    func sendDataView(accountList: Array<accounts>) {
        self.AccountList = accountList
        self.homepageTableView.reloadData()
    }
    
    func sendBankAccountDetailView(accountDetail: Array<accountDetail>) {
        self.bankAccount = accountDetail
    }
    
    func sendCashAccountDetailView(accountDetail: Array<accountDetail>) {
        self.cashAccount = accountDetail
    }
    
    func sendCreditAccountDetailView(accountDetail: Array<accountDetail>) {
        self.creditAccount = accountDetail
    }
    
    func sendTotalMoneyBankView(totalMoney: Int) {
        self.bankAccountMoney = String(totalMoney)
    }
    
    func sendTotalMoneyCashView(totalMoney: Int) {
        self.cashAccountMoney = String(totalMoney)
    }
    
    func sendTotalMoneyCreditView(totalMoney: Int) {
        self.creditAccountMoney = String(totalMoney)
    }
}

extension homepageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccountList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homepageCell", for: indexPath) as! homepageTableViewCell
        let part = AccountList[indexPath.row]
        
        cell.tableViewImage.image = UIImage(named: "card")
        //cell.tableViewImage.image = UIImage(named: part.picture!)
        cell.accountLabel.text = part.name
        cell.processLabel.text = "Recent Activities"
        
        switch indexPath.row {
        case 0:
            cell.moneyLabel.text = self.bankAccountMoney! + " €"
            switch bankAccount.count{
            case 1:
                cell.process1.text = bankAccount[0].activity
                cell.price1.text = bankAccount[0].price! + " €"
                cell.process2.text = ""
                cell.price2.text = ""
            case 2:
                cell.process1.text = bankAccount[0].activity
                cell.price1.text = bankAccount[0].price! + " €"
                cell.process2.text = bankAccount[1].activity
                cell.price2.text = bankAccount[1].price! + " €"
            default :
                cell.process1.text = "No Activity"
                cell.price1.text = ""
                cell.process2.text = ""
                cell.price2.text = ""
            }
        case 1:
            cell.moneyLabel.text = self.cashAccountMoney! + " €"
            switch cashAccount.count{
            case 1:
                cell.process1.text = cashAccount[0].activity
                cell.price1.text = cashAccount[0].price! + " €"
                cell.process2.text = ""
                cell.price2.text = ""
            case 2:
                cell.process1.text = cashAccount[0].activity
                cell.price1.text = cashAccount[0].price! + " €"
                cell.process2.text = cashAccount[1].activity
                cell.price2.text = cashAccount[1].price! + " €"
            default :
                cell.process1.text = "No Activity"
                cell.price1.text = ""
                cell.process2.text = ""
                cell.price2.text = ""
            }
        case 2:
            cell.moneyLabel.text = self.creditAccountMoney! + " €"
            switch creditAccount.count{
            case 1:
                cell.process1.text = creditAccount[0].activity
                cell.price1.text = creditAccount[0].price! + " €"
                cell.process2.text = ""
                cell.price2.text = ""
            case 2:
                cell.process1.text = creditAccount[0].activity
                cell.price1.text = creditAccount[0].price! + " €"
                cell.process2.text = creditAccount[1].activity
                cell.price2.text = creditAccount[1].price! + " €"
            default :
                cell.process1.text = "No Activity"
                cell.price1.text = ""
                cell.process2.text = ""
                cell.price2.text = ""
            }
        default: break
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
        performSegue(withIdentifier: "homepageToDetail", sender: indexPath.row)
    }
    
}




