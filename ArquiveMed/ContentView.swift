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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // -- Custom Nav Bar
                VStack(spacing: 4) {
                    HStack {
                        Text("Clinica Drefahl")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Image(systemName: "person.crop.circle") // Profile Image Placeholder
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .padding([.horizontal, .top])
                    
                    // Welcome, Fabio (under title)
                    Text("Welcome, Fabio!")
                        .font(.headline)
                        .padding(.bottom, 8)
                }
                
                // -- Main Buttons
                HStack(spacing: 16) {
                    Button(action: {
                        // Action: Add new patient
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
                    
                    Button(action: {
                        // Action: Add photos
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
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // -- “View Patients” Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "eye")
                            .foregroundColor(.blue)
                        Text("View Patients")
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
                        
                        DatePicker("", selection: $startDate, displayedComponents: .date)
                            .labelsHidden()
                        
                        Text(" - ")
                        
                        DatePicker("", selection: $endDate, displayedComponents: .date)
                            .labelsHidden()
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
                .padding([.horizontal, .top])
                
                // -- “Patients Found” Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "person.2")
                            .foregroundColor(.blue)
                        Text("Patients Found")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom, 4)
                    
                    // Table Header
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
                    .cornerRadius(8)
                    
                    // Table Rows
                    VStack(spacing: 0) {
                        ForEach(patients, id: \.self) { patient in
                            HStack {
                                Text(patient)
                                Spacer()
                                Text("04/07/03")
                                Spacer()
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.gray)
                            }
                            .frame(height: 50)   // Make rows a bit taller
                            .padding(.horizontal)
                            
                            Divider()
                        }
                    }
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
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
    }
}

#Preview {
    ContentView()
}
