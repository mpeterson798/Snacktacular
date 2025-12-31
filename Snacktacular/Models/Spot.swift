//
//  Spot.swift
//  Snacktacular
//
//  Created by Matthew Peterson on 12/28/25.
//

import Foundation
import FirebaseFirestore

struct Spot: Identifiable, Codable {
    @DocumentID var id: String?
    var name = ""
    var address = ""
    
}

extension Spot {
    static var preview: Spot {
        let newSpot = Spot(id: "1", name: "Boston Public Market", address: "Boston, MA")
        return newSpot
    }
}
