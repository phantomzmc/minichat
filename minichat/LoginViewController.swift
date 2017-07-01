//
//  LoginViewController.swift
//  minichat
//
//  Created by Thannathrn Yuwasin on 5/29/2560 BE.
//  Copyright © 2560 Thannathrn Yuwasin. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var username_text: UITextField!
    @IBOutlet weak var password_text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // สร้างตัวแปร tap ให้เป็น UITap เเล้วเรียกใช้งาน func dismisskeyboard เเล้วทำการ add ตัวแปร tap เข้าไปใช้งาน
        let tap:UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    //สร้าง func dismiss เพื่อทำการซ่อน keyboard
    func dismissKeyboard(){
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginOnClick(_ sender: Any) {
        if((username_text.text?.characters.count)! < 8){
            username_text.backgroundColor = UIColor.init(red: 232/255 , green: 192/255, blue: 123/255, alpha: 1)
            Alert().ShowAlert(title: "Error", message: "กรุณากรอก E-mail ให้ถูกต้อง", viewController: self)
            
            return
        }
        else{
            username_text.backgroundColor = UIColor.white
        }
        if((password_text.text?.characters.count)! < 8){
            password_text.backgroundColor = UIColor.init(red: 232/255 , green: 192/255, blue: 123/255, alpha: 1)
            Alert().ShowAlert(title: "Error", message: "กรุณากรอก Password ให้ถูกต้อง", viewController: self)
            return
        }
        else{
            password_text.backgroundColor = UIColor.white
        }
        
        let email = username_text.text
        let password = password_text.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (firebaseUser, firebaseUserError) in
            if firebaseUserError != nil {
                
                Alert().ShowAlert(title: "Error Login", message:"Login ผิดพลาด", viewController: self)
            }
            else{
                //Alert().ShowAlert(title: "Suceess", message: "Login สำเร็จ", viewController: self)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }

    @IBAction func RegisterOnClick(_ sender: Any) {
    }
    @IBAction func ForgetOnClick(_ sender: Any) {
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
