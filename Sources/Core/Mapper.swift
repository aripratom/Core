//
//  File.swift
//  
//
//  Created by Aria Pratomo on 01/03/22.
//

import Foundation
import Alamofire

public protocol Mapper {
    associatedtype Request
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(request:Request?, response: Response) -> Entity
    func transformEntityToDomain(entity: Entity) -> Domain
    func transformResponseToDomain(response: Response) -> Domain
}
