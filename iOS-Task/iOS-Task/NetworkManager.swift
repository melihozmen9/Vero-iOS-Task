//
//  NetworkManager.swift
//  iOS-Task
//
//  Created by Kullanici on 26.02.2023.
//

import Foundation

class NetworkManager : ObservableObject {
    
   @Published var datas = [ArrayModel]()
    
    func fetchData(){
        var request = URLRequest(url: URL(string: "https://api.baubuddy.de/dev/index.php/v1/tasks/select")!,timeoutInterval: Double.infinity)
        let accessToken = "75941f351f82e43bd263c8c266b4a3bf02570ac1"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
           
         if let data = data {
              let decoder = JSONDecoder()
              do {
                  let decodedData = try decoder.decode([ArrayModel].self, from: data)
                  DispatchQueue.main.async {
                      self.datas = decodedData
                      print(self.datas[0].colorCode)
                      //print("first data from decoded dat came from jeson decoder   \(self.datas)")
                  }
                  
                 
              } catch  {
                  print(error)
              }
              
            
            print(String(describing: error))
          
          }
//            let StringData = String(data: data!, encoding: .utf8)!
//          print("String Data = \(StringData)")
        }

        task.resume()
      


    }
}
