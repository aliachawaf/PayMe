//
//  Refund.swift
//  PayMe
//
//  Created by Alia Chawaf on 03/04/2019.
//  Copyright © 2019 Chawaf Alia & Gestin Rémi. All rights reserved.
//

import Foundation

class Refund {
    
    var amount: Double
    var travellerToRefund: Traveller
    var travellerInDebt : Traveller
    
    init(amount: Double, travellerToRefund: Traveller, travellerInDebt: Traveller) {
        self.amount = amount
        self.travellerInDebt = travellerInDebt
        self.travellerToRefund = travellerToRefund
    }
    
    func refundDescription() -> String {
        return ( travellerInDebt.fullname() + " doit " + String(amount) + "€ à " + travellerToRefund.fullname())
    }
}
