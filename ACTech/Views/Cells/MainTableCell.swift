//
//  MainTableCell.swift
//  ACTech
//
//  Created by mac on 9/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MainTableCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var numberLabel: UILabel!
    @IBOutlet fileprivate weak var cvvLabel: UILabel!
    @IBOutlet fileprivate weak var imgView: UIView!

    var setting: ACSetting? {
        didSet {
            guard let setting = setting else { return }
            
            nameLabel.text = setting.owner
            numberLabel.text = setting.number
            cvvLabel.text = String(describing: setting.cvv ?? 44)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = ""
        numberLabel.text = ""
        cvvLabel.text = ""

    }
}

extension MainTableCell {
    class func cell(tableView: UITableView, indexPath: IndexPath, setting: ACSetting? = nil) -> MainTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell", for: indexPath) as! MainTableCell
        cell.setting = setting
        cell.selectionStyle = .none
        
//        cell.imgView.layer.cornerRadius = cell.imgView.frame.height / 2
//        cell.imgView.layer.masksToBounds = true
        
        return cell
    }
}
