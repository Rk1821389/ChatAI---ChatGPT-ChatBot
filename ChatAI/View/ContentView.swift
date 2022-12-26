//
//  ContentView.swift
//  ChatAI
//
//  Created by Manoj kumar on 23/12/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [MessageModel]()
    @State var isTyping = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(models, id: \.message) { message in
                        if message.isChatbot {
                            HStack {
                                VStack {
                                    Image("chatBot")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(30)
                                        .background(
                                            Capsule()
                                                .stroke()
                                        )
                                    Spacer()
                                }
                                Text(message.message)
                                    .foregroundColor(.white)
                                    .font(.callout)
                                    .padding(.all)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .foregroundColor(.accentColor)
                                    )
                                Spacer(minLength: 50)
                            }
                        } else {
                            HStack {
                                Spacer(minLength: 50)
                                Text(message.message)
                                    .foregroundColor(.white)
                                    .font(.callout)
                                    .padding(.all)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .foregroundColor(.gray)
                                    )
                                VStack {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 25))
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(30)
                                        .background(
                                            Capsule()
                                                .stroke()
                                        )
                                }
                            }
                        }
                    }
                }
                
                Spacer()
               
                if isTyping {
                    HStack {
                        VStack {
                            Image(systemName: "person.fill")
                                .font(.system(size: 25))
                                .frame(width: 60, height: 60)
                                .cornerRadius(30)
                                .background(
                                    Capsule()
                                        .stroke()
                                )
                        }
                        
                        Text("Typing...")
                            .foregroundColor(.white)
                            .padding(.all)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.accentColor)
                            }
                        
                        Spacer()
                    }
                }
                
                HStack {
                    TextField("Type here..", text: $text)
                        .padding(.all)
                        .background(
                            Capsule()
                                .stroke(lineWidth: 0.5)
                        )
                    
                    Button {
                        send()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .padding(.all)
                    }
                    .background(
                        Circle()
                            .foregroundColor(.accentColor)
                    )

                }
                
            }
            .onAppear(perform: {
                viewModel.setup()
            })
            .padding(.horizontal)
            .navigationTitle("Ask Code")
            
        }
    }
    
    func send() {
        withAnimation {
            self.isTyping = true
        }
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else
        {
            return
        }
        
        models.append(MessageModel(message: text, isChatbot: false))
        self.text = ""
        viewModel.send(text: text) { response in
            DispatchQueue.main.async {
                withAnimation {
                    self.isTyping = false
                }
                self.models.append(MessageModel(message: response.message, isChatbot: true))
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
