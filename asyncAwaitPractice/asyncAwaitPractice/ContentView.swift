//
//  ContentView.swift
//  asyncAwaitPractice
//
//  Created by Chan Jung on 6/14/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vm.data, id: \.0.hashValue) { datum in
                VStack {
                    Image(uiImage: datum.0)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    Text(datum.1)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(style: .init(lineWidth: 2))
                        .foregroundColor(.orange)
                )
            }
        }
        .task {
            await vm.fetchAllSynchronousley()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
