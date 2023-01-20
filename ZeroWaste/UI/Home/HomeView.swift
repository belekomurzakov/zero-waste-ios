import SwiftUI
import RealmSwift


struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @ObservedResults(UtilizedItem.self) var utilizedItems
    @EnvironmentObject var game: Game
    
    private let sortDescriptors = [ SortDescriptor(keyPath: "createdDate", ascending: false) ]
    
    var body: some View {
        VStack {
            Image(game.getLevel(point: utilizedItems.count).image())
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.top, 30)
            
            Text(game.getLevel(point: utilizedItems.count).rawValue).font(.title).padding()
            
            ProgressView(value: Double(utilizedItems.count % 10), total: 10)
                .frame(width: 250)
                .padding(.bottom, 10)
                .tint(Color.green)
            
            NavigationView {
                List {
                    Section("Last actions") {
                        ForEach(utilizedItems.sorted(by: sortDescriptors), id: \.self) { item in
                            NavigationLink(destination: HistoryDetailView(utilizedItem: item)) {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                    Text(viewModel.dateFormatter.string(from: item.createdDate)).font(.caption2).opacity(0.4)
                                }
                                .padding(.vertical, 0.2)
                            }
                        }.onDelete(perform: $utilizedItems.remove)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
