//
//  File.swift
//  
//
//  Created by Aria Pratomo on 01/03/22.
//

import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
