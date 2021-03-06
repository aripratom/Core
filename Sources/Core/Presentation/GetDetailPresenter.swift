//
//  File.swift
//  
//
//  Created by Aria Pratomo on 03/03/22.
//

import SwiftUI
import Combine

public class GetDetailPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    private let _request: Request
    
    @Published public var item: Response?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(useCase: Interactor, request: Request, response: Response? = nil) {
        _useCase = useCase
        _request = request
        item = response
    }
    
    public func execute() {
        isLoading = true
        _useCase.execute(request: _request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
                print("GET Detail Presenter:  \(item)")
            })
            .store(in: &cancellables)
    }
}
