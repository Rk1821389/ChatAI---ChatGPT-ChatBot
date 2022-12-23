//
//  ViewModel.swift
//  ChatAI
//
//  Created by Manoj kumar on 23/12/22.
//

import Foundation
import OpenAISwift

final class ViewModel: ObservableObject {
    init() { }
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "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")
    }
    
    func send(text: String, completion: @escaping (MessageModel) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(MessageModel(message: output, isChatbot: true))
            case .failure(_):
                break
            }
        })
    }
}
