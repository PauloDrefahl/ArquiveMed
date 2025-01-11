import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var filterOption: String = "Both"
    @State private var patients: [String] = [
        "Alexander Valley",
        "Alexander Valley",
        "Alexander Valley"
    ]
    
    // For the custom popup
    @State private var showAddPatientView = false
    
    // For camera usage
    @State private var showCamera = false
    @State private var capturedImages: [UIImage] = []
    
    var body: some View {
        ZStack {
            // 1) Main content
            NavigationView {
                VStack(spacing: 0) {
                    
                    // -- Custom Nav Bar
                    VStack(spacing: 0) {
                        HStack {
                            // Search Button (left)
                            Button(action: {
                                // Handle search action
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.black)
                            }
                            .padding(.trailing, 8)
                            
                            Text("Clinica Drefahl")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .padding([.horizontal, .top])
                        
                        // Left-aligned welcome text
                        Text("Welcome, Fabio!")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                    }
                    
                    // Divider to visually separate nav bar from the rest
                    Divider()
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    
                    // -- Main Buttons
                    HStack(spacing: 16) {
                        // Show the popup overlay for AddPatientView
                        Button(action: {
                            showAddPatientView = true
                        }) {
                            HStack {
                                Image(systemName: "person.badge.plus")
                                Text("New Patient")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        
                        // 2) Open the camera and append images
                        Button(action: {
                            showCamera = true
                        }) {
                            HStack {
                                Image(systemName: "camera")
                                Text("Add Photos")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        // Present camera sheet
                        .sheet(isPresented: $showCamera) {
                            CameraPicker(images: $capturedImages)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                    
                    // -- “View Patients” Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "eye")
                                .foregroundColor(.black)
                            Text("Search Patients")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        // Name Search
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            Text("Name:")
                                .fontWeight(.semibold)
                            TextField("Search", text: $searchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Date Range
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.gray)
                            Text("Date:")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            HStack(spacing: 6) {
                                DatePicker("", selection: $startDate, displayedComponents: .date)
                                    .labelsHidden()
                                Text("-")
                                DatePicker("", selection: $endDate, displayedComponents: .date)
                                    .labelsHidden()
                            }
                        }
                        
                        // Segmented Picker
                        HStack {
                            Text("Search By:")
                                .fontWeight(.semibold)
                            Picker("Search By", selection: $filterOption) {
                                Text("Both").tag("Both")
                                Text("Name").tag("Name")
                                Text("Date").tag("Date")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                    
                    // -- “Patients Found” Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "person.2")
                                .foregroundColor(.black)
                            Text("Patients Found")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        // Entire table in a single VStack
                        VStack(spacing: 0) {
                            // Header row
                            HStack {
                                Text("Patient Name")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("Registered Date")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("...")
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            
                            // Divider between header & rows
                            Divider()
                            
                            // Table rows
                            ForEach(patients, id: \.self) { patient in
                                HStack {
                                    Button(action: {
                                        // Handle patient name tap
                                    }) {
                                        Text(patient)
                                            .foregroundColor(.primary)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Spacer()
                                    Text("04/07/03")
                                    
                                    Spacer()
                                    Button(action: {
                                        // Action menu for patient row
                                    }) {
                                        Image(systemName: "ellipsis")
                                            .foregroundColor(.gray)
                                    }
                                    .buttonStyle(.plain)
                                }
                                .frame(height: 50)
                                .padding(.horizontal)
                                
                                Divider()
                            }
                        }
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    // Show a preview of captured images (if you want)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(capturedImages, id: \.self) { img in
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                    
                    Spacer()
                    
                    // -- Bottom Navigation
                    HStack {
                        Button(action: {
                            // Action for Add
                        }) {
                            VStack {
                                Image(systemName: "plus")
                                Text("Add")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                        Button(action: {
                            // Action for Settings
                        }) {
                            VStack {
                                Image(systemName: "gear")
                                Text("Settings")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                        Button(action: {
                            // Action for Remove
                        }) {
                            VStack {
                                Image(systemName: "trash")
                                Text("Remove")
                                    .font(.caption)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                }
                .navigationBarHidden(true)
            }
            
            // 3) Dimmed background + popup for New Patient
            if showAddPatientView {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                
                AddPatientPopup(showAddPatientView: $showAddPatientView)
                    .frame(width: 350, height: 400)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 4)
                    .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    ContentView()
}
