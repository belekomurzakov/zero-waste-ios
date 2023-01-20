import SwiftUI
import MapKit

struct ClusterMap: UIViewRepresentable {
    
    @State var cans : [Can]
    @State var region =  MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.1951, longitude: 16.6068),
        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1 )
    )
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: ClusterMap
        
        init(_ parent: ClusterMap) {
            self.parent = parent
        }
        
        /// showing annotation on the map
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? LandmarkAnnotation else { return nil }
            return AnnotationView(can: annotation.can, annotation: annotation, reuseIdentifier: AnnotationView.ReuseID)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        ClusterMap.Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        ///  creating a map
        let view = MKMapView()
        /// connecting delegate with the map
        view.delegate = context.coordinator
        view.setRegion(region, animated: false)
        view.mapType = .standard
        
        for can in cans {
            let annotation = LandmarkAnnotation(coordinate: can.coordinate, can: can)
            view.addAnnotation(annotation)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}

class LandmarkAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let can: Can
    
    init(coordinate: CLLocationCoordinate2D, can: Can) {
        self.coordinate = coordinate
        self.can = can
        super.init()
    }
}

/// here posible to customize annotation view
let clusterID = "clustering"

class AnnotationView: MKMarkerAnnotationView {
    static let ReuseID = "cultureAnnotation"
    private let can: Can
    
    init(can: Can, annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.can = can
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = clusterID
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        switch (can.commodityWasteSeparated.lowercased()) {
        case "biological waste":
            markerTintColor = .red
        case "clothes":
            markerTintColor = .black
        case "paper":
            markerTintColor = .blue
        case "plastic, beverage cartons and cans":
            markerTintColor = .gray
        case "stained glass":
            markerTintColor = .green
        case "white glass":
            markerTintColor = .green
        default:
            markerTintColor = .black
        }
        
        glyphText = can.commodityWasteSeparated
        displayPriority = .defaultLow
    }
}
