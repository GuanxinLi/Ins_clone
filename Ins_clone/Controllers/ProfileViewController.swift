//
//  ProfileViewController.swift
//  Ins_clone
//
//  Created by Guanxin Li on 2/26/18.
//  Copyright © 2018 Guanxin. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var logOffButton: UIButton!
    @IBAction func logOff(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        PFUser.logOutInBackground{ _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let rootHome = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                UIApplication.shared.keyWindow?.rootViewController = rootHome
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
