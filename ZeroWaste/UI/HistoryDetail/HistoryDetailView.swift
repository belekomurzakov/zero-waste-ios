import SwiftUI
import RealmSwift

struct HistoryDetailView: View {
    
    @ObservedRealmObject var utilizedItem: UtilizedItem
    @StateObject var viewModel : HistoryDetailViewModel
    let dateString : String
    
    init(utilizedItem: UtilizedItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy HH:mm")
        dateString = dateFormatter.string(from: utilizedItem.createdDate)
        
        self._utilizedItem = ObservedRealmObject(wrappedValue: utilizedItem)
        self._viewModel = StateObject(wrappedValue: HistoryDetailViewModel(imageUrl: utilizedItem.image))
    }
    
    var body: some View {
        if viewModel.image == nil {
            ProgressView("Please wait...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
        } else {
            DataLoaded
        }
    }
}


extension HistoryDetailView {
    var DataLoaded: some View {
        VStack(alignment: .leading) {
            Image(uiImage: viewModel.image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Group {
                Text("Name").font(.headline)
                Text(utilizedItem.name)
            }.padding(.leading, 10)
            
            Divider()
            
            Group {
                Text("Number").font(.headline)
                Text(String(utilizedItem.number))
            }.padding(.leading, 10)
            
            Divider()
            
            Group{
                Text("Date/Time").font(.headline)
                Text(dateString)
            }.padding(.leading, 10)
            
            Divider()
            
            Spacer()
        }
    }
}

struct HistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryDetailView(utilizedItem: UtilizedItem())
    }
}
