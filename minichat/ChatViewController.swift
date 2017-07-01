//
//  ChatViewController.swift
//  minichat
//
//  Created by Thannathrn Yuwasin on 6/9/2560 BE.
//  Copyright © 2560 Thannathrn Yuwasin. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var inputMessegeTxt: UITextField!
    @IBOutlet weak var chatTableView: UITableView!

    
    
//    var messageDataArray = [MessageData]()
    var firDataSnapshotArray:[DataSnapshot]! = [DataSnapshot]()
    var databaseRef: DatabaseReference!
    private var _databaseHandle:DatabaseHandle! = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inputMessegeTxt.delegate = self as? UITextFieldDelegate
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        
        
        // Do any additional setup after loading the view.
        if (Auth.auth().currentUser == nil) {
            let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LayoutLogin") as! LoginViewController
            //self.navigationController?.pushViewController(loginView, animated: true)
            //self.navigationController?.present(loginView,animated: true,completion: nil)
            let navigationController = UINavigationController(rootViewController: loginView)
            self.present(navigationController,animated: true,completion: nil)
            
        }
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(ChatViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        registerForKeyboardNotification()
        
//        var messageData = MessageData(msgText: "Hell")
//        messageDataArray.append(messageData)
//        messageData = MessageData(msgText: "Thunnthorn")
//        messageDataArray.append(messageData)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        databaseRelese()
        databaseInit()
    }
    
    func databaseInit(){
        databaseRef = Database.database().reference()
        _databaseHandle = self.databaseRef.child("MiniChat").observe(.childAdded, with: { (firebaseSnapshot) in
            self.firDataSnapshotArray.append(firebaseSnapshot)
            let indexPathOfLastRow = IndexPath(row: self.firDataSnapshotArray.count-1,section:0)
            self.chatTableView.insertRows(at: [indexPathOfLastRow], with:.automatic)
        })
        
    }
    func databaseRelese(){
        if (_databaseHandle != nil) {
            self.databaseRef.child("MiniChat").removeObserver(withHandle: _databaseHandle)
            _databaseHandle = nil
        }
    }
    
    
    @IBAction func sendMessage(_ sender: Any) {
        if(inputMessegeTxt.text!.characters.count > 0){
            let messageData = MessageData(msgText: inputMessegeTxt.text!, msgDateTime: Const.CurrentDateTimeToStr())
            onSendMessage(messageData:messageData)
            inputMessegeTxt.text = ""
            
    
        }
    }
    
    func onSendMessage(messageData:MessageData){
        let dataValue: Dictionary<String, AnyObject> =
            [
                MessageData.MSGTEXT_ID:messageData.MsgText as AnyObject,
                MessageData.MSGDATETIME_ID:messageData.MsgDateTime as AnyObject
            ]
        self.databaseRef.child("MiniChat").childByAutoId().setValue(dataValue)
    }
    
    
    @IBAction func logoutClick(_ sender: Any) {
        logout()
        if (Auth.auth().currentUser == nil) {
            let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LayoutLogin") as! LoginViewController
            //self.navigationController?.pushViewController(loginView, animated: true)
            //self.navigationController?.present(loginView,animated: true,completion: nil)
            let navigationController = UINavigationController(rootViewController: loginView)
            self.present(navigationController,animated: true,completion: nil)
            
        }

    }
    deinit {
        databaseRelese()
        deregisterfromKeyboardNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //deregisterfromKeyboardNotification()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messageDataArray.count
        return firDataSnapshotArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firDataSnapshot = self.firDataSnapshotArray[indexPath.row]
        let snapshotValue = firDataSnapshot.value as! Dictionary<String,AnyObject>
        
        var strText = ""
        if let tempstrText = snapshotValue[MessageData.MSGTEXT_ID] as! String! {
            strText = tempstrText
        }
        
        var strDateTime = ""
        if let tempsteDateTime = snapshotValue[MessageData.MSGDATETIME_ID] as! String! {
            strDateTime = tempsteDateTime
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as? ChatVCCell {
            if (strText != "") {
                let messageData = MessageData(msgText: strText, msgDateTime: strDateTime)
                cell.setValue(messageData: messageData)
            }
            return cell
        }
        else{
            let cell = ChatVCCell()
            if (strText != "") {
                let messageData = MessageData(msgText: strText, msgDateTime: strDateTime)
                cell.setValue(messageData: messageData)
                
            }
            return cell
        }
    }

//        let messageData = messageDataArray[indexPath.row]
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as? ChatVCCell
//        {
//            cell.setValue(messageData: messageData)
//            return cell
//        }
//        else {
//            let cell = ChatVCCell()
//            cell.setValue(messageData: messageData)
//            return cell
//        }

        

    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }*/
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    func deregisterfromKeyboardNotification(){
        NotificationCenter.default.removeObserver(self,name:Notification.Name.UIKeyboardDidShow,object:self.view.window)
        NotificationCenter.default.removeObserver(self,name:Notification.Name.UIKeyboardDidHide,object:self.view.window)
    }
    
    
    
    func keyboardWillShow(_ sender:NSNotification){
        if inputMessegeTxt.isEditing {
            if let userInfo = sender.userInfo{
                if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
                    let keyboardOffset = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
                {
                    if keyboardSize.height == keyboardOffset.height
                    {
                        if self.view.frame.origin.y == 0
                        {
                            UIView.animate(withDuration: 0.20, animations:
                            {
                                self.view.frame.origin.y -= keyboardSize.height
                            })
                        }
                    }
                    else
                    {
                        UIView.animate(withDuration: 0.20, animations:
                            {
                                self.view.frame.origin.y += keyboardSize.height
                        })
                    }
                }
                else
                {
                    
                }
            }
        }
    }
    
    func keyboardWillHide(_ sender:NSNotification){
        if self.view.frame.origin.y != 0{
            if let userInfo = sender.userInfo{
                if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
                {
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
        }
        
    }
    
    
    func logout(){
        do {
            try Auth.auth().signOut()
        }
        catch let error as NSError{
            Alert().ShowAlert(title: "Error", message: error.localizedDescription, viewController: self)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
