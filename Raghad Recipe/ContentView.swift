//
//  ContentView.swift
//  Raghad Recipe
//
//  Created by Raghad Nawaf on 18/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 150)
                    
                Text("There's no recipe yet")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Text("Please add your recipes")
                    .font(.body)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .navigationTitle("Food Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Upimage()) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.orange)
                            
                    }
                }
            }
            
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ContentView()
}
