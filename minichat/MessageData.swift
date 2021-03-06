//
//  MessageData.swift
//  minichat
//
//  Created by Thannathrn Yuwasin on 6/21/2560 BE.
//  Copyright © 2560 Thannathrn Yuwasin. All rights reserved.
//

import Foundation

class MessageData  {
    
    static let MSGTEXT_ID = "Text"
    static let MSGDATETIME_ID = "DataTime"
    static let MSGUSEREMAIL = "UserEmail"
    
    private var msgText:String!
    private var msgDateTime:String!
    private var msgUserEmail:String!
    
    var MsgText:String{
        return msgText
    }
    var MsgDateTime:String{
        return msgDateTime
    }
    var MsgUserEmail:String{
        return msgUserEmail
    }
    
    
    init(msgText:String ,msgDateTime:String ,msgUserEmail:String) {
        self.msgText = msgText
        self.msgDateTime = msgDateTime
        self.msgUserEmail = msgUserEmail
    }
    
}
