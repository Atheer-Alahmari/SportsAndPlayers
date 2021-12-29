//
//  Players+CoreDataProperties.swift
//  SportsAndPlayers
//
//  Created by Atheer Alahmari on 25/05/1443 AH.
//
//

import Foundation
import CoreData


extension Players {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Players> {
        return NSFetchRequest<Players>(entityName: "Players")
    }

    @NSManaged public var playerName: String?
    @NSManaged public var playerAge: String?
    @NSManaged public var playerHieght: String?
    @NSManaged public var sport: Sports?

}

extension Players : Identifiable {

}
