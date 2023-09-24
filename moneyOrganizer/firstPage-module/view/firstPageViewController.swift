//
//  firstPageViewController.swift
//  moneyOrganizer
//
//  Created by Sait KARACA on 24.09.2023.
//

import UIKit

class firstPageViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var presenterObject : ViewToPresenterFirstPageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FirstPageRouter.createModule(ref: self)
        
        if UserDefaults.standard.bool(forKey: "firstLaunch") {
            performSegue(withIdentifier: "toHomepage", sender: nil)
        } else {
            presenterObject?.readDatabase()
            
            
            button.alpha = 0
            label.text = ""
            button.setImage(UIImage(named: "getStartButton"), for: .normal)
            button.setTitle("", for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
                self.logoAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
                    self.textAnimation()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                        self.buttonAnimation()
                    }
                }
            }
        }
    }
    
    func logoAnimation(){
        let screenHeight = UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.5, animations : {
            
            self.logo.transform = CGAffineTransform(translationX: 0, y: (-screenHeight / 2) + 150)
        }, completion: nil)
    }
    
    func textAnimation() {
           let text = "Welcome to the mallet application, where you can record your expenses and income, track exchange rate changes."
           var charIndex = 0.0
           for letter in text {
               Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                   self.label.text?.append(letter)
               }
               charIndex += 0.3
           }
       }
    
    func buttonAnimation(){
        UIView.animate(withDuration: 1) {
            self.button.alpha = 1
        }
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "firstLaunch")
        performSegue(withIdentifier: "toHomepage", sender: nil)
        
    }
}
