import SwiftUI

struct HomeView: View {
    @State private var showingCamera = false
    @State private var showingGallery = false

    var body: some View {
        VStack {
            Image("app_logo")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.top, 50)

            Text("PetGuard Plants")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 50)

            HStack(spacing: 20) {
                Button(action: {
                    showingCamera = true
                }) {
                    Text("Take Photo")
                        .frame(width: 150, height: 150)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .fullScreenCover(isPresented: $showingCamera) {
                    CameraView()
                }

                Button(action: {
                    showingGallery = true
                }) {
                    Text("Choose Photo")
                        .frame(width: 150, height: 150)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .fullScreenCover(isPresented: $showingGallery) {
                    GalleryView()
                }
            }
            .padding()

            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
