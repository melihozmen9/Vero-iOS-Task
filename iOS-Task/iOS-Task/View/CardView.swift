//
//  CardView.swift
//  iOS-Task
//
//  Created by Kullanici on 28.02.2023.
//

import SwiftUI

struct CardView: View {
    var data : ArrayModel?
    var fetchedData : DataModel?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(data == nil ? fetchedData!.task! : data!.task)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Text(data == nil ? fetchedData!.title! : data!.title)
                .fontWeight(.bold)
               
            
            Text(data == nil ? fetchedData!.description_! : data!.description)
                .foregroundColor(.black)
        }
        .listRowBackground(Color(hex: data == nil ? fetchedData!.colorCode! : data!.colorCode ?? "#FFFFFF"))
        
    }
}

