//
//  RegisterViewController.swift
//  minichat
//
//  Created by Thannathrn Yuwasin on 5/30/2560 BE.
//  Copyright © 2560 Thannathrn Yuwasin. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    @IBOutlet weak var conpasswordtxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RegisterClick(_ sender: Any) {
        if((emailtxt.text?.characters.count)! < 8){
            emailtxt.backgroundColor = UIColor (red: 232/255, green: 192/255, blue: 123/255, alpha: 1)
            Alert().ShowAlert(title: "Error", message: "กรุณากรอกข้อมูลให้ถูกต้อง", viewController: self)
        }
        else{
            emailtxt.backgroundColor = UIColor.white
        }
        if ((passwordtxt.text?.characters.count)! < 8) {
            passwordtxt.backgroundColor = UIColor (red: 232/255, green: 192/255, blue: 123/255, alpha: 1)
            Alert().ShowAlert(title: "Error", message: "กรุณากรอกรหัสผ่านให้มากกว่า 8 ตัวอักษร", viewController: self)
        }
        else{
            passwordtxt.backgroundColor = UIColor.white
        }
        if !conpasswordtxt.text!.isEqual(passwordtxt.text!){
            conpasswordtxt.backgroundColor = UIColor (red: 232/255, green: 192/255, blue: 123/255, alpha:1)
            Alert().ShowAlert(title: "Error", message: "กรุณากรอกรหัสผ่านให้เหมือนกัน", viewController: self)
        }
        else{
            conpasswordtxt.backgroundColor = UIColor.white
        }
 
        
        let email = emailtxt.text
        let password = passwordtxt.text
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (firebaseUser, firebaseError) in
            if let error = firebaseError{
                Alert().ShowAlert(title: "Error", message: error.localizedDescription, viewController: self)
            }
            else{
                let alert = UIAlertController(title: "Complete", message: "ทำการลงทะเบียนสำเร็จ", preferredStyle :.alert)
                let resultAlert = UIAlertAction(title:"OK",style:.default, handler:{
                    (alertAction) in
                    self.navigationController!.popViewController(animated:true)
                })
                alert.addAction(resultAlert)
                self.present(alert, animated: true, completion: nil)
                    return
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


