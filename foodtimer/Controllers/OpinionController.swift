//
//  OpinionController.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 17/09/2023.
//

import UIKit

class OpinionController: UIViewController, OpinionsManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    func didUpdateOpinions(_ opinionsManager: OpinionsManager, opinions: OpinionsModel) {
        DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var opinionsManager = OpinionsManager()
    var delegate: OpinionsManagerDelegate?
    var opinionCell = OpinionCell()
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.backBarButtonItem?.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        opinionsManager.delegate = self
        opinionsManager.performRequest{}
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OpinionCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        opinionsManager.opinionsTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! OpinionCell
            
        let opinion = opinionsManager.opinionsTable[indexPath.row]
        cell.configure(with: opinion)
        
        
        return cell
    }
}
