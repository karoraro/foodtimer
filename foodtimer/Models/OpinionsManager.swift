//
//  OpinionsManager.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 17/09/2023.
//

import Foundation

protocol OpinionsManagerDelegate {
    func didUpdateOpinions(_ opinionsManager: OpinionsManager, opinions: OpinionsModel)
    func didFailWithError(error: Error)
}

class OpinionsManager {
    
    var delegate: OpinionsManagerDelegate?
    
    var opinionsTable: [OpinionsModel] = []
    
    func performRequest(completion: @escaping () -> Void) {
        //1.Create URL
        if let url = URL(string: "https://vwaapqcjr1.execute-api.eu-west-1.amazonaws.com/dev/survey") {
            
            //2.Create URLSession
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let opinions = self.parseJSON(opinionsData: safeData) {
                        self.delegate?.didUpdateOpinions(self, opinions: opinions)
                        completion()
                    }
                }
            }
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON(opinionsData: Foundation.Data) -> OpinionsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(OpinionsData.self,from: opinionsData)
            
            var date = ""
            var rate = 0
            var message = ""
            
            opinionsTable = []
            
            for i in 0...decodedData.data.count-1 {
                
                date = decodedData.data[i].date
                rate = decodedData.data[i].rate
                message = decodedData.data[i].message
                
                let opinions = OpinionsModel(date: date, rate: rate, message: message)
                
                opinionsTable.append(opinions)
            }
            
            let opinions = OpinionsModel(date: date, rate: rate, message: message)
            return opinions
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
            
        }
        
    }
}
