//
//  search.swift
//  Raghad Recipe
//
//  Created by Raghad Nawaf on 23/04/1446 AH.
//

import Foundation
import SwiftUI

struct search: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                // العنوان الرئيسي وزر الإضافة
                HStack {
                    Text("Food Recipes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        // تنفيذ العملية المطلوبة عند الضغط على زر "+"
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.orange)
                    }
                }
                .padding(.horizontal)
                
                // مربع البحث
                HStack {
                    TextField("Search", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        // تنفيذ العملية المطلوبة عند الضغط على زر البحث الصوتي
                    }) {
                        Image(systemName: "mic.fill")
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                // صورة الوصفة مع نص الوصف
                ZStack(alignment: .bottomLeading) {
                    Image("salad_image") // اسم الصورة التي سيتم عرضها
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                    
                    // تدرج أسود أسفل الصورة
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 80)
                    
                    // النصوص فوق التدرج
                    VStack(alignment: .leading, spacing: 5) {
                        Text("")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        Text("See All")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                    .padding()
                }
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all)) // لون الخلفية
            .navigationBarHidden(true) // إخفاء شريط التنقل
        }
    }
}

// معاينة الواجهة
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    search()
}
