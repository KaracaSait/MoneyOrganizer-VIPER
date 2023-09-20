//
//  exchangeRateViewController.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 17.09.2023.
//

import UIKit

class exchangeRateViewController: UIViewController {
    
    var exchangeRatePresenterObject : ViewToPresenterExchangeRateProtocol?
    var exchangeRateList = [Dictionary<String, Double>.Element]()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var backButtonImage: UIBarButtonItem!
    @IBOutlet weak var exchangeRateTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeRateRouter.createModule(ref: self)

        exchangeRateTableView.dataSource = self
        exchangeRateTableView.delegate = self
    
        activityIndicator.color = .gray
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        backButtonImage.image = UIImage(named: "backButton")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        exchangeRatePresenterObject?.readCurrencies()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension exchangeRateViewController: PresenterToViewExchangeRateProtocol {
    
    func sendViewCurrenciesList(list:[Dictionary<String, Double>.Element]) {
        exchangeRateList = list
        DispatchQueue.main.async {
            self.exchangeRateTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
}

extension exchangeRateViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = exchangeRateList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "exchangeRateCell", for: indexPath) as! exchangeRateTableViewCell
        cell.rateName.text = part.key
        cell.ratePrice.text = String(part.value)
        
        return cell
    }
    
}
