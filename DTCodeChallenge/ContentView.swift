//
//  ContentView.swift
//  DTCodeChallenge
//
//  Created by Dhruvin  on 31/08/22.
//

import SwiftUI
import GoogleMaps

struct ContentView: View {

    var transportType = ["All", "Tram", "Train"]
   
    @ObservedObject var transportModel = TransportModel.shared
    
     var body: some View {
        
         ZStack {
             
             Color(hex: 0xf6fcf2)
             .edgesIgnoringSafeArea(.all)
        
             VStack(spacing: 0) {
                 ShimmerView().frame(width: UIScreen.main.bounds.width, height: 5)
                 HStack{
                     Text("Departures").fontWeight(.semibold)
                         .font(.system(size: 24))
                         .foregroundColor(Color.black)
                         .frame(width: 150, height: 100, alignment: .center)
                         .animation(.easeInOut, value: 5.0)
                         .padding(.leading, 15)
                         .padding(.trailing, 15)
                     Spacer()
                     Picker("Please choose a color", selection: $transportModel.type) {
                            ForEach(transportType, id: \.self) {
                            Text($0)
                        }
                     }.padding(.leading, 15)
                    .padding(.trailing, 15)
                 }
                 
                 GoogleMapsView()
                     .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                     .edgesIgnoringSafeArea(.bottom)
                     .animation(.easeInOut, value: 1.0)
             }
             
         }
     }
    
 }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


