//
//  WelcomeController.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 31/08/2023.
//

import UIKit

class WelcomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            self.performSegue(withIdentifier: "goToMenu", sender: self)
        }
    }
    
}
