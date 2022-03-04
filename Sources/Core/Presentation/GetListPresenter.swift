//
//  File.swift
//  
//
//  Created by Aria Pratomo on 01/03/22.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

public class GetListPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == [Response] {
    
    private let _useCase: Interactor
    private var cancellables: Set<AnyCancellable> = []
    
    @Published public var list: [Response] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    public func getList(request: Request?) {
        isLoading = true
        _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                    print("error")
                case .finished:
                    self.isLoading = false
                    print("finished")
                }
            }, receiveValue: { list in
                self.list = list
            })
            .store(in: &cancellables)
    }
    
    
}
