//
//  TravellerCoreData.swift
//  PayMe
//
//  Created by Alia Chawaf on 29/03/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//
import Foundation

// MARK: -
/**
 Traveller type
 
 **firstname**: Traveller -> String
 **lastname**: Traveller -> String
 **arrivalDate**: Traveller -> Date
 **departureDate**: Traveller -> Date
 **trip**: Traveller -> Trip
 */

extension Traveller {
    
    // MARK: -
    
    /// firstnale of Traveller
    public var firstname: String {return self.pfirstname ?? ""}
    /// lastname of Traveller
    public var lastname: String {return self.plastname ?? ""}
    /// arriaval Date to the trip of Traveller
    public var arrivalDate: Date { return self.parrivalDate!}
    /// departure Date to the trip of Traveller
    public var departureDate: Date { return self.pdepartureDate!}
    /// trip of Traveller
    public var trip: Trip {return self.ptrip!}
    
    
    /// initialize a 'Traveller'
    ///
    /// - Parameters:
    ///   - firstname: <#firstname description#>
    ///   - lastname: <#lastname description#>
    ///   - arrival: <#arrival description#>
    ///   - departure: <#departure description#>
    ///   - trip: <#trip description#>
    convenience init(firstname: String, lastname: String, arrival: Date, departure: Date, trip:Trip) {
        self.init(context: CoreDataManager.context)
        self.pfirstname = firstname
        self.plastname = lastname
        self.pdepartureDate = departure
        self.parrivalDate = arrival
        self.ptrip = trip
    }
    
    /// text description of a traveller
    func fullname() -> String {
        return self.firstname + " " + self.lastname
    }
    
    /// Update infos of the Traveller
    ///
    /// - Parameters:
    ///   - firstname: the new firstname to change to Traveller
    ///   - lastname: the new lastname to change to Traveller
    ///   - arrivalDate: the new arrivalDate to change to Traveller
    ///   - departureDate: the new departureDate to change to Traveller
    func updateTravellerInfos(firstname: String, lastname: String, arrivalDate: Date, departureDate: Date) {

        self.pfirstname = firstname
        self.plastname = lastname
        self.parrivalDate = arrivalDate
        self.pdepartureDate = departureDate
    }
}
