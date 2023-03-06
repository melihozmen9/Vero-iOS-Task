//
//  NetworkManager.swift
//  iOS-Task
//
//  Created by Kullanici on 26.02.2023.
//

import Foundation
import CoreData
import SwiftUI

class NetworkManager : ObservableObject {
    
   @Published var datas = [ArrayModel]()
    @State private var accessToken : String?
    @Environment(\.managedObjectContext) var context
    // saving JSON to Coredata
    
    func saveData(context : NSManagedObjectContext){
        datas.forEach { data in
            let dataEntity = DataModel(context:context)
            dataEntity.task = data.task
            dataEntity.title = data.title
            dataEntity.description_ = data.description
            dataEntity.sort = data.sort
            dataEntity.wageType = data.wageType
            dataEntity.businessUnit = data.businessUnit
            dataEntity.businessUnitKey = data.BusinessUnitKey
            dataEntity.parentTaskID = data.parentTaskID
            dataEntity.preplanningBoardQuickSelect = data.preplanningBoardQuickSelect
            dataEntity.colorCode = data.colorCode
            dataEntity.workingTime = data.workingTime
            dataEntity.isAvailableInTimeTrackingKioskMode = data.isAvailableInTimeTrackingKioskMode
        }
        
        do {
            try context.save()
            print("Successfully saved to Coredata.")
        } catch  {
            print(error.localizedDescription)
        }
    }
//    func login() {
//        let url = URL(string: "https://api.baubuddy.de/index.php/login")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        
//        let loginData = LoginData(username: "365", password: "1")
//        
//        let jsonData = try! JSONEncoder().encode(loginData)
//        
//        request.httpBody = jsonData
//       
//        let authHeaderValue = "Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz"
//        
//        request.setValue(authHeaderValue, forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(OAuthResponse.self, from: data)
//                // Access the OAuth data using response.oauth
//                DispatchQueue.main.async {
//                    self.accessToken = response.oauth.accessToken
//                    print("loginden gelen access token : \(response.oauth.accessToken)")
////                    self.fetchData(context: self.context)
//                }
//             
//            } catch {
//                print("Error decoding JSON: \(error)")
//            }
//            
//        }
//        task.resume()
//    }
//    struct LoginData: Encodable {
//        let username: String
//        let password: String
//    }

    func fetchData(context:NSManagedObjectContext){
        if accessToken != nil {
        var request = URLRequest(url: URL(string: "https://api.baubuddy.de/dev/index.php/v1/tasks/select")!,timeoutInterval: Double.infinity)
        //let accessToken = "fd461d55bc20b59a48e8f8abde93d46037f56f83"
        request.addValue("Bearer \("d77d029c31e6cb3b2770078630f63ccb5fc573ce")", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
           
         if let JSONData = data {
             
             let response = response as! HTTPURLResponse
             
             if response.statusCode == 404 {
                 print("error API Error")
                 return
             }
             
              let decoder = JSONDecoder()
              do {
                  let decodedData = try decoder.decode([ArrayModel].self, from: JSONData)
                  DispatchQueue.main.async {
                      self.datas = decodedData
                      print("json calıştı")
                      self.saveData(context: context)
                     print(self.datas)
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
}
