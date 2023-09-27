//
//  Questionnaire.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 09/09/2023.
//

import UIKit

class QuestionnaireController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    
    var opinionsManager = OpinionsManager()
    
    var tag = 0
    lazy var stars: [UIButton]! = [star1,star2,star3,star4,star5]
    var rate = 0
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem?.isHidden = true
        
        for i in 0...self.stars.count-1 {
            self.stars[i].alpha = 0.0
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var myDelay = 0.0
        for i in 0...self.stars.count-1 {
            UIView.animate(withDuration: 1.0, delay: myDelay) {
                self.stars[i].alpha = 1.0
            }
            myDelay += 0.1
        }
    }
    
    @IBAction func starPressed(_ sender: UIButton) {
        
        for star in stars {
            if star.tag <= sender.tag {
                star.setImage(UIImage.init(named: "filled_star"), for: .normal)
                rate = star.tag
            } else {
                star.setImage(UIImage.init(named: "empty_star"), for: .normal)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.endEditing(true) {
            print(textField.text!)
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Leave your comment here."
            return false }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Calculate the new text length if this change is applied
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Set your desired character limit
        let characterLimit = 200 // Change this to your preferred limit
        
        // Check if the new text length exceeds the character limit
        if newText.count <= characterLimit {
            return true // Allow the change
        } else {
            return false // Reject the change, text exceeds the limit
        }
    }
    
    
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        sendButton.setTitle("Sent!", for: UIControl.State.normal)
        self.performSegue(withIdentifier: "goToPopup", sender: self)
        message = textField.text!
        postRequest()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        for star in stars {
            star.setImage(UIImage.init(named: "empty_star"), for: .normal)
        }
        
        textField.text = ""
        textField.placeholder = "Comment here"
        sendButton.setTitle("Send", for: UIControl.State.normal)
    }
    
    // code below allows to set a smaller popup window
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPopup" {
            let popoverVc = segue.destination
            popoverVc.modalPresentationStyle = .popover
            popoverVc.popoverPresentationController?.delegate = self;
            popoverVc.preferredContentSize = CGSize(width: 300, height: 450)
        }
    }
    
    func postRequest() {
        
        // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid
        
        let parameters: [String: Any] = ["rate": rate, "message": message, "dodus": "Gość!"]
        print("Rate: \(rate)",", Message: \(message)")
        // create the url with URL
        let url = URL(string: "https://vwaapqcjr1.execute-api.eu-west-1.amazonaws.com/dev/survey")! // change server url accordingly
        
        // now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            // convert parameters to Data and assign dictionary to httpBody of request
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        // create the session object
        let session = URLSession.shared
        
        // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                return
            }
            
            // ensure there is valid response code returned from this HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
                    
            else {
                print("Invalid Response received from the server")
                return
            }
            
            // ensure there is data returned
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            
            do {
                // create json object from data or use JSONDecoder to convert to Model stuct
                if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    print(jsonResponse)
                    // handle json response
                } else {
                    print("data maybe corrupted or in wrong format")
                    throw URLError(.badServerResponse)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        // perform the task
        task.resume()
    }
    
    @IBAction func showButtonPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "goToOpinions", sender: self)
        opinionsManager.performRequest{}
        
    }
    
    
}


