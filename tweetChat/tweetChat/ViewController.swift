//
//  ViewController.swift
//  tweetChat
//
//  Created by Imcrinox Mac on 19/12/1444 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var twittextMessage: UITextView!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var countLbl: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        twittextMessage.delegate = self
        profileImage.layer.cornerRadius = profileImage.layer.frame.width / 2
        twittextMessage.backgroundColor = UIColor.clear
        twittextMessage.textColor = UIColor.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_ : )), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ note:NSNotification) {
        let userinfo = note.userInfo
        let keyBoardBounds = (userinfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userinfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        let animations = {
            self.underView.transform = CGAffineTransform(translationX: 0, y: -deltaY)
        }

            if duration > 0
        {
                UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState, .curveLinear], animations: animations, completion: nil)
            }
        else {
            animations()
        }
    }
    
    @objc func keyboardWillHide(_ note: NSNotification) {
        let userInfo = note.userInfo
        let duration = (userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let animation = {
            self.underView.transform = .identity
        }
        
        if duration > 0  {
            UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState,.curveLinear],animations:  animation, completion: nil)
                
            }
        else {
            animation()
        }
    }
}


extension ViewController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputTextLength = text.count - range.length + twittextMessage.text.count
            if inputTextLength > 150 {
            return false
        }
        countLbl.text = "\(150 - inputTextLength)"
        return true
    }
    }
