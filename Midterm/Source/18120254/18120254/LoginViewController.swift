//
//  LoginViewController.swift
//  18120254
//
//  Created by HUYTU on 11/22/20.
//  Copyright © 2020 HUYTU. All rights reserved.
//

import UIKit

struct Login: Codable {
    let username, password: String
}


class LoginViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    // username & password from api
    var loginUsername = ""
    var loginPassword = ""
    
    // api string
    let loginURLString = "https://5fbb989bc09c200016d40c60.mockapi.io/Login"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginAPI(completion: {str in self.parseJson(jsonString: str) })
        
    }
    
    func parseJson(jsonString: String){
        let jsonData = jsonString.data(using: .utf8)!
        let login = try! JSONDecoder().decode(Login.self, from: jsonData)
        loginUsername = login.username
        loginPassword = login.password
        
    }
    
    func loginAPI(completion: @escaping ((String) -> Void)){
        
        let request = NSMutableURLRequest(url: URL(string: loginURLString)!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, respone, error) in
            if let httpStatus = respone as? HTTPURLResponse {
                // validate error & data
                guard error == nil && data != nil else { return }
                // check for respone
                if httpStatus.statusCode != 200 {
                    print("Failed")
                }
                else{
                    let rcvStr = String(data: data!, encoding: .utf8)!
                    completion(rcvStr)
                }
            }
            else{
                print("Failed")
            }
        }
        task.resume()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if usernameTextField.text == loginUsername && passTextField.text == loginPassword {
            let dest = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
            dest.modalPresentationStyle = .fullScreen
            present(dest, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "LOGIN FAILED!", message: "Wrong username or password", preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .cancel, handler: nil)
            alert.addAction(retryAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}
