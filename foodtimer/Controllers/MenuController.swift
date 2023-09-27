//
//  MenuController.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 31/08/2023.
//

import UIKit

class MenuController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
        // navigation bar BACK buttion in QUESTIONNAIRE visible when code below enabled:
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.isNavigationBarHidden = false
//    }
    
    @IBAction func eggsButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToEgg", sender: self)
    }
    
    @IBAction func pizzaButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToPizza", sender: self)
    }
    
    @IBAction func customButtonPressed(_ sender: UIButton) { self.performSegue(withIdentifier: "goToCustom", sender: self)
    }
    
}
