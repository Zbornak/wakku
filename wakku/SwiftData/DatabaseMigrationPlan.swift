//
//  DatabaseMigrationPlan.swift
//  wakku
//
//  Created by Mark Strijdom on 31/01/2024.
//

import SwiftData
import SwiftUI

enum DatabaseMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ModelSchemaV1.self, ModelSchemaV2.self]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(fromVersion: ModelSchemaV1.self, toVersion: ModelSchemaV2.self) { context in
        let videos = try context.fetch(FetchDescriptor<ModelSchemaV1.Video>())
        var usedTitles = Set<String>()
        
        for video in videos {
            if usedTitles.contains(video.title) {
                context.delete(video)
            }
            
            usedTitles.insert(video.title)
        }
        
        try context.save()
    } didMigrate: { _ in
        //
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
}
