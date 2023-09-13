//
//  detailViewController.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 7.09.2023.
//

import UIKit

class detailViewController: UIViewController {

    var detailPresenterObject : ViewToPresenterDetailProtocol?
    
    var whichAccount:accounts?
    var detailList = [accountDetail]()
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var dateImage: UIImageView!
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var recentActivitiesLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailRouter.createModule(ref: self)
        
        detailTableView.dataSource = self
        detailTableView.delegate = self
        
        let customBackButtonImage = UIImage(named: "backButton")
        let customBackButtonMaskImage = UIImage(named: "backButton")
        navigationController?.navigationBar.backIndicatorImage = customBackButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackButtonMaskImage
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        detailImage.image = UIImage(named: "detailBack")
        dateImage.image = UIImage(named: "dateImage")
        
        let plusButtonImage = UIImage(named: "plusButton")
        plusButton.setTitle("", for: .normal)
        plusButton.setImage(plusButtonImage, for: .normal)
        view.addSubview(plusButton)
        
        let minusButtonImage = UIImage(named: "minusButton")
        minusButton.setTitle("", for: .normal)
        minusButton.setImage(minusButtonImage, for: .normal)
        view.addSubview(minusButton)
        
        accountLabel.text = whichAccount?.name!
        recentActivitiesLabel.text = "Recent Activities"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailPresenterObject?.dataRead(whichAccount: (whichAccount?.id)!)
        detailPresenterObject?.recentActivities(whichAccount: (whichAccount?.id)!)
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        UserDefaults.standard.set("plus", forKey: "process")
        detailPresenterObject?.showAlert(title: "Add", message: "Add", whichAccount: (whichAccount?.id)!)
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        UserDefaults.standard.set("minus", forKey: "process")
        detailPresenterObject?.showAlert(title: "Minus", message: "Minus", whichAccount: (whichAccount?.id)!)
    }
    
}

extension detailViewController: PresenterToViewDetailProtocol {
    
    func presenterAlert(_ alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)
    }
    
    func reloadTableView(whichAccount:Int) {
        detailTableView.reloadData()
        detailPresenterObject?.recentActivities(whichAccount: whichAccount)
    }
    
    func sendDataView(detailList:Array<accountDetail>) {
        
        self.detailList = detailList
        
    }
    
    func sendTotalMoneyView(totalMoney: Int) {
        
        self.totalMoneyLabel.text =  "$ " + String(totalMoney)
    }
    
    func sendRecentActivitiesView(recentActivities: String) {
        self.priceLabel.text = recentActivities
    }
}

extension detailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = detailList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! detailTableViewCell
        cell.tableViewImage.image = UIImage(named: "detailCell")
        
        cell.dateLabel.text = part.date
        cell.explanationLabel.text = "Explanation : \(part.activity ?? "-")"
        cell.transactionLabel.text = part.price! + "$" 
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let del = self.detailList[indexPath.row].id!
            detailPresenterObject?.dataDel(id: del, whichAccount: (whichAccount?.id)!)
            tableView.deleteRows(at: [indexPath], with: .fade)
            detailPresenterObject?.recentActivities(whichAccount: (whichAccount?.id)!)
        }
    }
}
