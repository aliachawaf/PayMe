//
//  TravellerCoreData.swift
//  PayMe
//
//  Created by Alia Chawaf on 29/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//
import Foundation

extension Traveller {
    
    public var arrivalDate: Date { return self.parrivalDate!}
    public var departureDate: Date { return self.pdepartureDate!}
    public var firstname: String {return self.pfirstname ?? ""}
    public var lastname: String {return self.plastname ?? ""}
    public var trip: Trip {return self.ptrip!}
    
    convenience init(firstname: String, lastname: String, arrival: Date, departure: Date, trip:Trip) {
        self.init(context: CoreDataManager.context)
        self.pfirstname = firstname
        self.plastname = lastname
        self.pdepartureDate = departure
        self.parrivalDate = arrival
        self.ptrip = trip
    }

 
}
