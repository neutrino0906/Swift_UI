//
//  SwiftUIView.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 15/04/24.
//

import SwiftUI

struct SwiftUIView: View {
    @State var time = 30
    @State var timer : Timer?
    
    var body: some View {
        Text("\(time)")
        Button("restart"){
            startTimer()
        }
        .onAppear(perform: {
            startTimer()
        })
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            time -= 1
            if(time == 0){
                resetTimer()
            }
        }
    }
    
    func resetTimer(){
        time = 30
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    SwiftUIView()
}
