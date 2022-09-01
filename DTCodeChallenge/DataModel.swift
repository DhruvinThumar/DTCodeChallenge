//
//  DataModel.swift
//  DTCodeChallenge
//
//  Created by Dhruvin  on 31/08/22.
//

import SwiftUI
import GoogleMaps

struct MapAnnotationResult:Codable {

    var typeId: Int?
    var departureTime: String?
    var name: String?
    var latitude: Double?
    var longitude: Double?
    var isExpress: Bool?
    var hasMyKiTopUp: Bool?
    var route: String?
    
}

class DataViewModel: ObservableObject {
    
    @Published var dataResult = [MapAnnotationResult]()
    
    func getResultData(){
        
        guard let dataUrl = URL(string: "https://github.com/elementengineering/Mobile-App-Coding-Challenge/blob/master/data/data.json")
        else { return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: dataUrl)
            
                let response = try JSONDecoder()
                    .decode([MapAnnotationResult].self, from: data)
                DispatchQueue.main.async { [weak self] in
                    self?.dataResult = response
                    print("AAA:\(String(describing: response))")
                }
              } catch let err{
                 print("*** ERROR ***:\(err)")
                 self.loadData()
              }
        }
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        let data = try? Data(contentsOf: url)
        let dataRecords = try? JSONDecoder().decode([MapAnnotationResult].self, from: data!)
        
        
        DispatchQueue.main.async {
            self.dataResult = dataRecords!
        }
        
    }
}
