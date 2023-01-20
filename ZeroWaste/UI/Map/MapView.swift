import SwiftUI
import MapKit

struct MapView: View {

    @StateObject var viewModel = MapViewModel()

    var body: some View {
        if viewModel.cans.isEmpty {
            ProgressView("Please wait...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
        } else {
//            Map(coordinateRegion: $region,annotationItems: viewModel.cans) { can in
//                MapAnnotation(coordinate: can.coordinate) {
//                    PlaceAnnotationView(title: can.name)
//                }
//            }
            ClusterMap(cans: viewModel.cans).edgesIgnoringSafeArea(.top)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
