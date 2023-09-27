//
//  PopUpController.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 10/09/2023.
//

import UIKit

class PopUpController: UIViewController,UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var okButton: UIButton!


    
    @IBAction func okButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToMenu", sender: self)
    }
    
    
}
