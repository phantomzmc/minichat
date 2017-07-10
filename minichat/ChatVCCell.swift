//
//  ChatVCCell.swift
//  minichat
//
//  Created by Thannathrn Yuwasin on 6/21/2560 BE.
//  Copyright © 2560 Thannathrn Yuwasin. All rights reserved.
//

import UIKit

class ChatVCCell: UITableViewCell {

    @IBOutlet weak var TextLbl: UILabel!
    @IBOutlet weak var DateTimeMessageTxt: UILabel!

    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setValue(messageData:MessageData) {
        TextLbl.text = messageData.MsgText
        DateTimeMessageTxt.text = messageData.MsgDateTime
        userEmailLabel.text = messageData.MsgUserEmail
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
