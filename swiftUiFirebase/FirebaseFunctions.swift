//
//  FirebaseFunctions.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 15/04/24.
//

import Foundation
import Firebase
import UIKit

class FirebaseFunctions {
    let auth = Auth.auth()
    
    
    func FirebaseSignIn(_ email : String, _ password: String, completion: @escaping (Bool, String?) -> Void){
        auth.signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error{
                completion(false, error.localizedDescription)
                return
            }
            
            completion(true, nil)
            
        }
    }
    
    
    func FirebaseSignUp(_ email : String, _ password: String, _ name: String, _ phoneNumber: String, completion: @escaping (Bool, String?) -> Void){
            Auth.auth().createUser(withEmail: email, password: password) { Result, Error in
                if let Error = Error{
                    completion(false, Error.localizedDescription)
                }
                completion(true, nil)
                    
                
                
            }
        }
    
    
    
    
    
    func sendVerificationCode(to phoneNumber: String, completion: @escaping (Bool) -> Void)
    {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            print(phoneNumber)
              if let error = error {
                  print(error.localizedDescription)
                  completion(false)
                  return
              }
              UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
              completion(true)
          }
    }
    
    func verifyCode(_ code: String, completion: @escaping (Bool) -> Void)
    {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        print(verificationID)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            
            if let error = error {
                completion(false)
            }
            
            completion(true)
        }
    }
        
        
    }
