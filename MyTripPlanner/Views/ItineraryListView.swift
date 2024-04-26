import SwiftUI
import SwiftData

struct ItineraryListView: View {
    @Environment(\.modelContext) private var context
    @Query var destinations: [Destination]
    @Query var places: [Place]
    
    var body: some View {
        
        List {
            if destinations.isEmpty {
                Text("No destinations added yet.")
                    .foregroundColor(.gray)
            } else {
                ForEach(destinations, id: \.self) { destination in
                    VStack(alignment: .leading) {
                        Text(destination.city + ", " + destination.country)
                            .font(.headline)
                        Text("Start Date: \(destination.startDate, formatter: dateFormatter)")
                        Text("End Date: \(destination.endDate, formatter: dateFormatter)")
                        Text("Travel days: \(daysBetween(startDate: destination.startDate, endDate: destination.endDate))")
                        
                    }
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            context.delete(destination)
                        }
                        
                    }
                    
                    
                }
            }
            
            
            
        }
        .navigationTitle("Itinerary List")
    }
     
    
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    func daysBetween(startDate: Date, endDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        return components.day ?? 0
    }
    
}
