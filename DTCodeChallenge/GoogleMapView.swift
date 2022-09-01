//
//  GoogleMapView.swift
//  DTCodeChallenge
//
//  Created by Dhruvin  on 31/08/22.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
     
     @StateObject var viewModel = DataViewModel()
    
     @ObservedObject var transportModel = TransportModel.shared
    
     func makeUIView(context: Context) -> GMSMapView {
        
        viewModel.getResultData()
         
        print("map created")
        let camera = GMSCameraPosition.perth
        let mapView = GMSMapView(frame: CGRect.zero, camera: camera)
        return mapView
     }
     
     func updateUIView(_ uiView: GMSMapView, context: Context) {
         print("markerrrr:\(transportModel.type)")
        
         uiView.clear()
         var markers = [GMSMarker]()
         for i in 0..<self.viewModel.dataResult.count{
             let data = self.viewModel.dataResult[i]
             
             if(transportModel.type == "Tram" && data.typeId == 0){
                 continue
             }else if(transportModel.type == "Train" && data.typeId == 1){
                 continue
             }
             
             
             let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: data.latitude ?? 0.0, longitude: data.longitude ?? 0.0))
             
             var type = ""
             if(data.typeId == 1){
                 type = "(Tram)"
             }else if(data.typeId == 0){
                 type = "(Train)"
             }
             
             marker.title = (data.name ?? "") + type
             marker.snippet = self.serverToLocal(date: data.departureTime ?? "")
             markers.append(marker)
             
             uiView.camera = GMSCameraPosition.camera(withLatitude: marker.position.latitude, longitude: marker.position.longitude, zoom: 10)
         }
         markers.forEach { $0.map = uiView }
         
     }
    
    func serverToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let localDate = dateFormatter.date(from: date)

        dateFormatter.dateFormat = "d MMM y, HH:mm a"
        return dateFormatter.string(from: localDate ?? Date())
    }

}

class TransportModel: ObservableObject {
    static let shared = TransportModel()

    @Published var type: String = "All"
}

extension GMSCameraPosition  {
     static var perth = GMSCameraPosition.camera(withLatitude: -31.952288, longitude: 115.861578, zoom: 14)
 }

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
