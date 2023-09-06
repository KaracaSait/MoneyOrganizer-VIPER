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
    var AccountList = [accounts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homepageRouter.createModule(ref: self)
        
        homepageTableView.dataSource = self
        homepageTableView.delegate = self
        
        veritabaniKopyala()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        presenterObject?.readAccountsFile()
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
        //self.homepageTableView.reloadData()
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
        
        cell.moneyLabel.text = "25000 $"
        cell.process1.text = "Starbucks"
        cell.process2.text = "Migros"
        cell.price1.text = "-50 $"
        cell.price2.text = "-250 $"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
        print(indexPath.row)
    }
    
}




