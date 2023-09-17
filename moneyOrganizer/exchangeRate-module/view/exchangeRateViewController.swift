//
//  exchangeRateViewController.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 17.09.2023.
//

import UIKit

class exchangeRateViewController: UIViewController {
    
    var exchangeRatePresenterObject : ViewToPresenterExchangeRateProtocol?
    var exchangeRateList = [String:Double]()

    @IBOutlet weak var exchangeRateTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeRateRouter.createModule(ref: self)

        exchangeRateTableView.dataSource = self
        exchangeRateTableView.delegate = self
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        exchangeRatePresenterObject?.readCurrencies()
    }
    
}

extension exchangeRateViewController: PresenterToViewExchangeRateProtocol {
    
    func sendViewCurrenciesList(list: [String : Double]) {
        exchangeRateList = list
        DispatchQueue.main.async {
            self.exchangeRateTableView.reloadData()
        }
    }
    
}

extension exchangeRateViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let keys = Array(exchangeRateList.keys)
        let partKeys = keys[indexPath.row]
        let values = Array(exchangeRateList.values)
        let partValues = values[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exchangeRateCell", for: indexPath) as! exchangeRateTableViewCell
        cell.rateName.text = partKeys
        cell.ratePrice.text = String(partValues)
        return cell
    }
    
}
