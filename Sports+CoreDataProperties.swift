//
//  Sports+CoreDataProperties.swift
//  SportsAndPlayers
//
//  Created by Atheer Alahmari on 25/05/1443 AH.
//
//

import Foundation
import CoreData


extension Sports {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sports> {
        return NSFetchRequest<Sports>(entityName: "Sports")
    }

    @NSManaged public var sportName: String?
    @NSManaged public var sportImage: Data?
    @NSManaged public var player: NSSet?

}

// MARK: Generated accessors for player
extension Sports {

    @objc(addPlayerObject:)
    @NSManaged public func addToPlayer(_ value: Players)

    @objc(removePlayerObject:)
    @NSManaged public func removeFromPlayer(_ value: Players)

    @objc(addPlayer:)
    @NSManaged public func addToPlayer(_ values: NSSet)

    @objc(removePlayer:)
    @NSManaged public func removeFromPlayer(_ values: NSSet)

}

extension Sports : Identifiable {

}
