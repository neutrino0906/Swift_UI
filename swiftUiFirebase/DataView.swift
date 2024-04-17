//
//  DataView.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 15/04/24.
//

import SwiftUI

struct DataView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        VStack(spacing: 40) {
            Text("Todo App")
            .foregroundStyle(.white)
            .frame(width: screenWidth * 0.5, height: 36)
            .background(Color("ButtonColor", bundle: nil))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .onTapGesture {
                let todoApplicationUrl : NSString = "todoApplication://"
                UIApplication.shared.open(URL(string: todoApplicationUrl as String)!)
            }
            
            Text("Gallery App")
        .foregroundStyle(.white)
        .frame(width: screenWidth * 0.5, height: 36)
        .background(Color("ButtonColor", bundle: nil))
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .onTapGesture {
            let todoApplicationUrl : NSString = "galleryApplication://"
            UIApplication.shared.open(URL(string: todoApplicationUrl as String)!)
        }
            
            
        Text("Timer App")
        .foregroundStyle(.white)
                .frame(width: screenWidth * 0.5, height: 36)
                .background(Color("ButtonColor", bundle: nil))
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .onTapGesture {
                    let todoApplicationUrl : NSString = "timerApplication://"
                    UIApplication.shared.open(URL(string: todoApplicationUrl as String)!)
                }
            
            
        Text("News App")
        .foregroundStyle(.white)
        .frame(width: screenWidth * 0.5, height: 36)
        .background(Color("ButtonColor", bundle: nil))
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .onTapGesture {
            let todoApplicationUrl : NSString = "newsApplication://"
            UIApplication.shared.open(URL(string: todoApplicationUrl as String)!)
        }
    }
        
    }
}

#Preview {
    DataView()
}
