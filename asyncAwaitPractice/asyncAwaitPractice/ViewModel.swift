//
//  ViewModel.swift
//  asyncAwaitPractice
//
//  Created by Chan Jung on 6/15/22.
//

import Foundation
import Combine
import UIKit

final class ViewModel: ObservableObject {
    @Published var data: [(UIImage, String)] = []
    
    private func fetchDataForURL(endpoint: String) async -> (UIImage, String)? {
        do {
            let url = URL(string: "https://picsum.photos/\(endpoint)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let img = UIImage(data: data) else { return nil }
            print("fetching for \(endpoint)!")
            return (img, endpoint)
        } catch {
            print("error")
            return nil
        }
    }
    
    @MainActor
    func fetchAllSynchronousley() async {
        let startingPoint = Date()
        
        let data1 = await fetchDataForURL(endpoint: "3200")!
        let data2 = await fetchDataForURL(endpoint: "2100")!
        let data3 = await fetchDataForURL(endpoint: "3490")!
        let data4 = await fetchDataForURL(endpoint: "1080")!
        let data5 = await fetchDataForURL(endpoint: "2300")!
        let data6 = await fetchDataForURL(endpoint: "300")!
        
        self.data.append(data1)
        print("appending 3200!")
        
        self.data.append(data2)
        print("appending 2100!")
        
        self.data.append(data3)
        print("appending 3490!")
        
        self.data.append(data4)
        print("appending 1080!")
        
        self.data.append(data5)
        print("appending 2300!")
        
        self.data.append(data6)
        print("appending 300!")
        
        let endpoint = startingPoint.timeIntervalSinceNow * -1
        
        print("\(endpoint) seconds elapsed!")
    }
    
    @MainActor
    func fetchAllAsynchronousley() async {
        let startingPoint = Date()
        
        async let data1 = fetchDataForURL(endpoint: "3200")!
        async let data2 = fetchDataForURL(endpoint: "2100")!
        async let data3 = fetchDataForURL(endpoint: "3490")!
        async let data4 = fetchDataForURL(endpoint: "1080")!
        async let data5 = fetchDataForURL(endpoint: "2300")!
        
        await self.data.append(data1)
        print("appending 3200!")
        
        await self.data.append(data2)
        print("appending 2100!")
        
        await self.data.append(data3)
        print("appending 3490!")
        
        await self.data.append(data4)
        print("appending 1080!")
        
        await self.data.append(data5)
        print("appending 2300!")
        
        let endpoint = startingPoint.timeIntervalSinceNow * -1
        
        print("\(endpoint) seconds elapsed!")
    }
}
