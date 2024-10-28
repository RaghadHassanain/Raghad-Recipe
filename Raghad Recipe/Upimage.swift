//
//  Upimage.swift
//  Raghad Recipe
//
//  Created by Raghad Nawaf on 18/04/1446 AH.
//




import SwiftUI
import UIKit

// Model

struct Ingredient: Identifiable {
    var id = UUID()
    var title: String
    var details: String
    var measurement: String
    var servingSize: Int
}

// ViewModel

class UpimageViewModel: ObservableObject {
    @AppStorage("Title") var title: String = ""
    @AppStorage("IngredientDetails") var ingredientDetails: String = ""
    
    @Published var ingredientTitle: String = ""
    @Published var selectedImage: UIImage?
    @Published var showAddIngredientSheet = false
    @Published var ingredients: [Ingredient] = []
    
    func saveData() {
        title = ingredientTitle
        ingredientDetails = self.ingredientDetails
    }
    
    func addIngredient(title: String, details: String, measurement: String, servingSize: Int) {
        let ingredient = Ingredient(title: title, details: details, measurement: measurement, servingSize: servingSize)
        ingredients.append(ingredient)
    }
}

// Views

struct Upimage: View {
    @StateObject private var viewModel = UpimageViewModel()
    @State private var showImagePicker = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                GroupBox {
                    ZStack {
                        if let selectedImage = viewModel.selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 330, height: 120)
                                .clipped()
                        } else {
                            VStack(spacing: 10) {
                                Button(action: { showImagePicker.toggle() }) {
                                    Image(systemName: "photo.badge.plus")
                                        .foregroundColor(Color.orange)
                                        .font(.system(size: 50, weight: .bold))
                                }
                                Text("Upload Image")
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                    .frame(width: 200, height: 50)
                            }
                        }
                    }
                    .frame(width: 330, height: 120)
                }
                .frame(width: 360, height: 150)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(style: StrokeStyle(lineWidth: 2, dash: [6])).foregroundColor(.orange))
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $viewModel.selectedImage)
                }

                VStack(alignment: .leading, spacing: 15) {
                    Text("Title: \(viewModel.title)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    TextField("Enter ingredient title", text: $viewModel.ingredientTitle)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                    
                    Text("Description")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    TextField("Enter ingredient details", text: $viewModel.ingredientDetails)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                        .frame(height: 90)
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Text("Add Ingredient")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: { viewModel.showAddIngredientSheet = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.orange)
                    }
                    .sheet(isPresented: $viewModel.showAddIngredientSheet) {
                        AddIngredientSheet(viewModel: viewModel)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)

                Spacer()
            }
            .padding(.top, 30)
            .navigationTitle("New Recipe")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.saveData() }) {
                        Text("Save")
                    }
                    .foregroundColor(Color.orange)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: ContentView()) {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                        .foregroundColor(Color.orange)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct AddIngredientSheet: View {
    @ObservedObject var viewModel: UpimageViewModel
    @State private var newIngredientTitle: String = ""
    @State private var newIngredientDetails: String = ""
    @State private var selectedMeasurement: String = "Spoon"
    @State private var servingSize: Int = 1

    var body: some View {
        VStack(spacing: 20) {
            Spacer(minLength: 50)
            Text("Ingredient Name")
                .font(.title)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .padding(.trailing, 140.0)
            TextField("Ingredient Name", text: $newIngredientTitle)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)

            Text("Measurement")
                .font(.title)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .padding(.trailing, 170.0)

            HStack {
                Button("🥄 Spoon") {
                    selectedMeasurement = "Spoon"
                }
                .frame(width: 120, height: 40)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(8)
                .padding()

                Button("🥛 Cup") {
                    selectedMeasurement = "Cup"
                }
                .frame(width: 120, height: 40)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(8)
                .padding()
            }

            Text("Serving")
                .font(.title)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .padding(.trailing, 250.0)

            Stepper(value: $servingSize, in: 1...10) {
                Text("Serving Size: \(servingSize)")
            }
            .padding(.horizontal)

            Spacer(minLength: 50)
            
            HStack {
                Button("Add") {
                    viewModel.addIngredient(title: newIngredientTitle, details: newIngredientDetails, measurement: selectedMeasurement, servingSize: servingSize)
                }
                .frame(width: 120, height: 40)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(8)
                .padding()

                Button("Cancel") {
                    // close sheet action
                }
                .frame(width: 120, height: 40)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .background(Color.orange)
                .cornerRadius(8)
                .padding()
            }
            Spacer()
        }
        .padding()
    }
}

// ImagePicker Component

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    Upimage()
}
