import SwiftUI
import Combine
import RealmSwift

struct CategoryDetailView: View {
    @EnvironmentObject var nav : Navigation
    @StateObject var viewModel: CategoryDetailViewModel
    @State var showBottomSheet = false
    @State private var inputNumber = ""
    private var category: String
    
    init(category: String) {
        self._viewModel = StateObject(wrappedValue: CategoryDetailViewModel(category: category))
        self.category = category
    }
    
    var body: some View {
        if viewModel.image == nil {
            ProgressView("Please wait...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
        } else {
            DataLoaded.navigationTitle(category)
        }
    }
}

extension CategoryDetailView {
    
    var DataLoaded: some View {
        VStack {
            Image(uiImage: viewModel.image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack() {
                Group {
                    Image(systemName: "trash").foregroundColor(.gray)
                    Text(String(viewModel.wasteType.cans)).foregroundColor(.gray)
                }
                Spacer().frame(maxWidth: 40)
                Group {
                    Image(systemName: "clock.arrow.2.circlepath").foregroundColor(.gray)
                    Text("\(viewModel.wasteType.decompositionTime) y.").foregroundColor(.gray)
                }
                Spacer().frame(maxWidth: 40)
                Group {
                    Image(systemName: "tortoise").foregroundColor(.gray)
                    Text(String(viewModel.wasteType.kills)).foregroundColor(.gray)
                }
            }
            
            Text(viewModel.wasteType.description).font(.subheadline).padding()
            
            Spacer()
            
            Button(action: {
                showBottomSheet.toggle()
            }) {
                Text("Sort it!")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.green))
                    .frame(width: 300, height: 50)
            }
            
            Spacer()
        }.sheet(isPresented: $showBottomSheet) {
            BottomSheetForm
                .presentationDetents([.fraction(0.30)])
                .presentationDragIndicator(.visible)
        }
    }
}

extension CategoryDetailView {
    
    var BottomSheetForm : some View {
        VStack {
            Text("Enter a number")
                .frame(alignment: .leading)
            
            HStack(spacing: 5) {
                Spacer()
                TextField("Number", text: $inputNumber)
                    .keyboardType(.numberPad)
                    .padding(.vertical, 10)
                    .padding(.leading, 10)
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                    .overlay(alignment: .trailing) {
                        if !inputNumber.isEmpty {
                            Button(action: { self.inputNumber = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                    }
                Spacer()
            }
            
            HStack {
                Button("Cancel") { showBottomSheet.toggle() }.padding()
                Spacer()
                Button("Confirm") {
                    let item = UtilizedItem()
                    item.name = self.category
                    item.image = viewModel.wasteType.imageUrl
                    item.number = Int(inputNumber) ?? 0
                    
                    LocalRepository.shared.addUtilizedItem(item: item)
                    showBottomSheet.toggle()
                    
                    nav.path.removeLast(nav.path.count) // Back to root
                }
                .padding()
            }
        }.frame(height: UIScreen.main.bounds.height/2)
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View { CategoryDetailView(category: "Her") }
}
