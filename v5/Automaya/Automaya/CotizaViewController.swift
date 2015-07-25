//
//  CotizaViewController.swift
//  Automaya
//
//  Created by Bancorp on 7/17/15.
//  Copyright (c) 2015 jmvarguez. All rights reserved.
//

import UIKit

class CotizaViewController: UIViewController {
    
    @IBOutlet weak var menuButton:UIBarButtonItem!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtTelefono: UITextField!
    
    @IBOutlet weak var txtMarca: UITextField!
    
    @IBOutlet weak var txtModelo: UITextField!
    
    @IBOutlet weak var txtFecha: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupTapped(sender: AnyObject) {
        
        var nomuser:NSString = txtNombre.text as NSString
        var emailuser:NSString = txtCorreo.text as NSString
        var teluser:NSString = txtTelefono.text as NSString
        
        var marcauser:NSString = txtMarca.text as NSString
        var modelouser:NSString = txtModelo.text as NSString
        var fechauser:NSString = txtFecha.text as NSString
        
        
        if ( nomuser.isEqualToString("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Registro Fallido!"
            alertView.message = "Falta su nombre"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if ( emailuser.isEqualToString("") || !isValidEmail(emailuser as String) ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Registro Fallido!"
            alertView.message = "Falta su correo"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }else if ( teluser.isEqualToString("")  ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Registro Fallido!"
            alertView.message = "Falta su telefono"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }else if ( marcauser.isEqualToString("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Registro Fallido!"
            alertView.message = "Falta la marca"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            
         
            
            var post:NSString = "nombre=\(nomuser)&email=\(emailuser)&telefono=\(teluser)&fechacita=\(fechauser)&tpservicio=cotiza&marca=\(marcauser)&modelo=\(modelouser)&accion=EnViar"
            
            NSLog("PostData: %@",post);
            
            var url:NSURL = NSURL(string: "http://linkitmx2.com/automaya_app/registrosolicitud.php")!
            
            var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            var postLength:NSString = String( postData.length )
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
            
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    var error: NSError?
                    
                    let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as! NSDictionary

                    
                    
                    let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
                    
                    
                    
                    //[jsonData[@"success"] integerValue];
                    
                    NSLog("Success: %ld", success);
                    
                    if(success == 1)
                    {
                        NSLog("Sign Up SUCCESS");
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        var error_msg:NSString
                        
                        if jsonData["error_message"] as? NSString != nil {
                            error_msg = jsonData["error_message"] as! NSString
                        } else {
                            error_msg = "Unknown Error"
                        }
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign Up Failed!"
                        alertView.message = error_msg as? String
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                        
                    }
                    
                } else {
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign Up Failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            }  else {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failure"
                if let error = reponseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
        
        
    }
    
    @IBAction func gotoLogin(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func isValidEmail(testStr:String) -> Bool {
        
        println("validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        var result = emailTest.evaluateWithObject(testStr)
        
        return result
        
    }

}
