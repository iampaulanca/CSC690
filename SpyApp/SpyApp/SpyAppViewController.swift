import UIKit

class SpyAppViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var secret: UITextField!
    @IBOutlet weak var output: UILabel!
    
    let factory = CipherFactory()
    var cipher: Cipher!
    
    //boolean for UITextFieldDelagate to allow special characters
    var alphaBool = false
    var atBash = false
    
    override func viewDidLoad() {
        //allow only numbers to be entered into secret UITextField!
        self.secret.delegate = self
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //if string is empty do nothing
        if string.isEmpty {
            return true
        }
        
        if textField == secret  {
            let alphaNumRegEx = "[0-9]"
            let predicate = NSPredicate(format: "SELF MATCHES %@", alphaNumRegEx)
            return predicate.evaluate(with: string)
            //if alphabool is true we only allow alphanumerical characters
        }
        if alphaBool == true {
            let alphaNumRegEx = "[a-zA-Z0-9]"
            let predicate = NSPredicate(format: "SELF MATCHES %@", alphaNumRegEx)
            return predicate.evaluate(with: string)
        } else if atBash == true{
            let alphaNumRegEx = "[a-zA-Z]"
            let predicate = NSPredicate(format: "SELF MATCHES %@", alphaNumRegEx)
            return predicate.evaluate(with: string)
        } else {
            return true
        }
        
    }
    
    @IBAction func cipherButtonPressed(_ sender: UIButton) {
        
        let key = sender.titleLabel!.text!

        if key == "AlphaNumeric" {
            if alphaBool == false {
               input.text = ""
            }
            alphaBool = true
            atBash = false
            self.input.delegate = self
        }
        else if key == "Atbash" {
            if atBash == false {
                input.text = ""
            }
            atBash = true
            alphaBool = false
            self.input.delegate = self
        } else {
            atBash = false
            alphaBool = false
        }

        cipher = factory.cipher(for: key)
        
    }
    
    @IBAction func encodeButtonPressed(_ sender: UIButton) {
        
        let plaintext = input.text!
        let secret = self.secret.text!
        
        if cipher != nil {
            if input.text!.isEmpty || secret.isEmpty {
                output.text = "Input and Secret is required"
            } else if output.text! == cipher.encode(plaintext, secret: secret){
                //create alert
                let alert = UIAlertController(title: "Already encrypted", message: "", preferredStyle: UIAlertControllerStyle.alert)
                //create action button to dismiss alert
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                //present alert
                self.present(alert, animated: true, completion: nil)
            } else {
                output.text = cipher.encode(plaintext, secret: secret)
            }
        } else {
            output.text = "Cipher required"
        }
    }
    
    
    @IBAction func decryptButtonPressed(_ sender: UIButton) {
        let encryptedText = input.text!
        let secret = self.secret.text!
        
        if cipher != nil {
            if input.text!.isEmpty || secret.isEmpty {
                output.text = "Input and Secret is required"
            } else if output.text == cipher.decrypt(encryptedText, secret: secret) {
                //create alert
                let alert = UIAlertController(title: "Already decrpted", message: "", preferredStyle: UIAlertControllerStyle.alert)
                //add action button to dismiss alert
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                //present alert
                self.present(alert, animated: true, completion: nil)
            } else {
                output.text = cipher.decrypt(encryptedText, secret: secret)
            }
        } else {
            output.text = "Cipher required"
        }
    }
    
}

