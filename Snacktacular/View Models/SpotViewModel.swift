//
//  SpotViewModel.swift
//  Snacktacular
//
//  Created by Matthew Peterson on 12/28/25.
//

import Foundation
import FirebaseFirestore

@Observable 
class SpotViewModel {
    
    static func saveSpot(spot: Spot) -> Bool {
        let db = Firestore.firestore()
        
        if let id = spot.id {  // if true the spot exists
            do {
                try db.collection("spots").document(id).setData(from: spot)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 Could not update data in 'spots' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
                try db.collection("spots").addDocument(from: spot)
                print("🐣 Data added successfully!")
                return true
            } catch {
                print("😡 Could not create a new spot in 'spots' \(error.localizedDescription)")
                return false
            }
        }
    }
    static func deleteSpot(spot: Spot) {
        let db = Firestore.firestore()
        guard let id = spot.id else {
            print("No spot.id")
            return
        }
        
        Task {
            do {
                try await db.collection("spots").document(id).delete()
            } catch {
                print("😡 Error: Could not delete document \(id). \(error.localizedDescription)")
            }
        }
    }
}
