//
//  ForgetPassowrdViewController.swift
//  minichat
//
//  Created by Thannathrn Yuwasin on 6/9/2560 BE.
//  Copyright © 2560 Thannathrn Yuwasin. All rights reserved.
//

import UIKit
import Firebase

class ForgetPassowrdViewController: UIViewController {

    @IBOutlet weak var email_txt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func resetPasswordOnClick(_ sender: Any) {
        if ((email_txt.text?.characters.count)! < 8 ) {
            email_txt.backgroundColor = UIColor (red: 232/255, green: 192/255, blue: 123/255, alpha: 1)
            Alert().ShowAlert(title: "Error", message: "กรุณากรอกตัวอักษรให้มากกว่า 8", viewController: self )
        }
        else{
            email_txt.backgroundColor = UIColor.white
            
            let email = email_txt.text
            Auth.auth().sendPasswordReset(withEmail: email!, completion: { (firebaseError) in
                
                if let error = firebaseError
                {
                    Alert().ShowAlert(title: "Error", message: error.localizedDescription, viewController: self)
                    return
                }
                else{
                    let alert = UIAlertController (title: "Susceed", message: "Reset Password สำเร็จ", preferredStyle: .alert)
                    let resultAlert = UIAlertAction (title: "OK", style: .default, handler: { (alertAction) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alert.addAction(resultAlert)
                    self.present (alert, animated: true, completion: nil)
                }
            })
            
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

}
