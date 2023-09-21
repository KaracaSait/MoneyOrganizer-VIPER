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
    
    var selectedIndexPath: IndexPath?
    
    @IBOutlet weak var backButtonImage: UIBarButtonItem!
    @IBOutlet weak var exchangeRateTableView: UITableView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var exchangeRateBackground: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false

        
        exchangeRateRouter.createModule(ref: self)

        exchangeRateTableView.dataSource = self
        exchangeRateTableView.delegate = self
        textField.delegate = self
    
        activityIndicator.color = .gray
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        backButtonImage.image = UIImage(named: "backButton")
        exchangeRateBackground.image = UIImage(named: "exchangeRateBackground")
        textField.backgroundColor = .clear
        
        priceLabel.text = "-"
        nameLabel.text = "-"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        exchangeRatePresenterObject?.readCurrencies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.setValue(1, forKey: "exchangeRate")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        cell.selectionStyle = .none
        if indexPath == selectedIndexPath {
            cell.tableViewCellBackground.image = UIImage(named: "tableViewCellBackgroundClick")
        } else {
            cell.tableViewCellBackground.image = UIImage(named: "tableViewCellBackground")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let part = exchangeRateList[indexPath.row]

        if selectedIndexPath != indexPath {
            selectedIndexPath = indexPath
        }
        
        exchangeRateTableView.reloadData()
        
        UserDefaults.standard.setValue(part.value, forKey: "exchangeRate")
        textField.text = ""
        self.priceLabel.text = String(part.value)
        self.nameLabel.text = part.key
    }
    
}

extension exchangeRateViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let number = Int(text + string){
            self.priceLabel.text = String(Double(number) * UserDefaults.standard.double(forKey: "exchangeRate"))
        }else{
            self.priceLabel.text = ""
        }
        
        if string.isEmpty {
            let remainingText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            if let remaining = Int(remainingText) {
                self.priceLabel.text = String(Double(remaining) * UserDefaults.standard.double(forKey: "exchangeRate"))
            }else{
                self.priceLabel.text = ""
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
