//
//  OpinionCell.swift
//  eggTimer2
//
//  Created by Karolina Obszyńska on 19/09/2023.
//

import UIKit

class OpinionCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var opinionLabel: UILabel!
    
    
    var opinionsManager = OpinionsManager()
    var stars: [UIImageView] = []
    
    func configure(with opinion: OpinionsModel) {
        dateLabel.text = opinion.date
        opinionLabel.text = opinion.message
        let rate = opinion.rate
        
        //Stars display settings:
        for star in stars {
            star.isHidden = true
        }
        
        for i in 0..<stars.count {
            if i < rate {
                stars[i].isHidden = false
            } else {
                stars[i].isHidden = true
            }
        }
        //Date formatting:
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Warsaw")
        
        if let date = dateFormatter.date(from: opinion.date) {
            // Format the date to "dd MMM yyyy HH:mm"
            dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = "Invalid Date"
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stars = [star1,star2,star3,star4,star5]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
