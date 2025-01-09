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
                VStack(spacing: 0) {
                    HStack {
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
                .padding(.bottom, 24) // More vertical space between buttons & next section
                
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
                .padding(.bottom, 24) // Extra margin before "Patients Found"
                
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
                            .frame(height: 50) // Make rows a bit taller
                            .padding(.horizontal)
                            
                            Divider()
                        }
                    }
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
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
