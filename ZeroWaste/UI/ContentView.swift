import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var showAlert = false
    @StateObject var game = Game()
    @StateObject var nav = Navigation()
    
    var body: some View {
        NavigationStack(path: $nav.path) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                MapView()
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }
                    .tag(1)
            }
            .accentColor(.blue)
            .overlay(FAB, alignment: .bottom)
            .navigationDestination(for: Int.self) { it in
                switch(it) {
                case 0: CategoryView()
                case 1: PhotoView()
                default: EmptyView()
                }
            }
        }
        .environmentObject(nav)
        .environmentObject(game)
    }
    
    var FAB: some View {
        Button(action: {
            showAlert.toggle()
        }) {
            Image(systemName: "arrow.3.trianglepath")
                .foregroundColor(.white)
                .padding(18)
                .background(Color.green)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding(.bottom, 20)
        .alert(
            "Choose a way to sort",
            isPresented: $showAlert,
            actions: {
                NavigationLink("Choose a category", value: 0)
                NavigationLink("Scan a photo", value: 1)
                Button("Dismiss", action: { self.showAlert = false })
            },
            message: { Text("Sort by photo or choose which category the item belongs to manually") }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Navigation: ObservableObject {
    @Published var path = NavigationPath()
}
