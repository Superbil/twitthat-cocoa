//
//  Rule+CoreDataProperties.swift
//  Twitthat
//
//  Created by Superbil on 2017/9/29.
//  Copyright © 2017年 Superbil. All rights reserved.
//
//

import Foundation
import CoreData


extension Rule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rule> {
        return NSFetchRequest<Rule>(entityName: "Rule")
    }

    @NSManaged public var site: String?
    @NSManaged public var keyword: String?
    @NSManaged public var replaceString: String?
    @NSManaged public var enable: Bool

}
