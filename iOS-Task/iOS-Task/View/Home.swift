//
//  Home.swift
//  iOS-Task
//
//  Created by Kullanici on 28.02.2023.
//

import SwiftUI
import Reachability

struct Home: View {
    @StateObject var jsonModel = NetworkManager()
    
    @State private var searchText = ""
    @State private var isShowingPhotoPicker = false
    @State private var imageToBeScan : UIImage?
    @State private var qrSearch : String?
    @Environment(\.managedObjectContext) var context
    
    var filteredResults: [DataModel] {
        if searchText.isEmpty {
            return Array(results)
        } else {
            let predicate = NSPredicate(format: "task CONTAINS[c] %@ OR description CONTAINS[c] %@", searchText, searchText)
            return results.filter { predicate.evaluate(with: $0) }
        }
    }
    
 
    
    // fetching from coredata
    @FetchRequest(entity: DataModel.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \DataModel.task, ascending: true)]) var results : FetchedResults <DataModel>
    
    var body: some View {
        
        VStack{
            // Checking if coredata exist
            if results.isEmpty{
                if jsonModel.datas.isEmpty{
                    ProgressView()
                        .onAppear {
                            //jsonModel.login()
                          jsonModel.fetchData(context: context)
                        }
                } else{
                    List(jsonModel.datas,id:\.self){ data in
                        // Display Fetched JSON Data
                        CardView(data: data)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            else {
                List(filteredResults){ data in                    // Display Fetched JSON Data
                    CardView(fetchedData: data)
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .sheet(isPresented: $isShowingPhotoPicker, content: {
            PhotoPicker( searchText: $searchText)
        })
        .navigationBarTitle(!results.isEmpty ? "Fetched CoreData" : "Fetched JSON")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {isShowingPhotoPicker = true}
                label: {
                    Text("Scan")
                    Image(systemName: "qrcode")
                }
                    
                } label: {
                    Label(
                        title : { Text("Menu")},
                        icon: { Image(systemName: "text.justify")  }
                    )
                }
                
            }
        }.refreshable {
            //remove data from coredata
            if hasInternetConnection(){
                do {
                    results.forEach{ (data) in
                        context.delete(data)
                    }
                    
                    try context.save()
                    
                } catch  {
                    print(error.localizedDescription)
                }
            }else {
                print("No internet connection. Data displayed from Core Data.")
            }
            
            self.jsonModel.datas.removeAll()
        }
        .searchable(text: $searchText)
    }
    
    
    
    func hasInternetConnection() -> Bool {
        let reachability = try! Reachability()
        
        switch reachability.connection {
        case .wifi, .cellular:
            return true
        case .unavailable:
            return false
        }
    }
    
    
}

