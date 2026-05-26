import SwiftUI
                        Image(systemName: "mic.fill")
                        Text("Recognize Song")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                }

                if isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    List(songs) { song in

                        HStack {

                            AsyncImage(url: URL(string: song.artwork)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 60, height: 60)
                            .cornerRadius(12)

                            VStack(alignment: .leading) {
                                Text(song.title)
                                    .font(.headline)

                                Text(song.artist)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Recall")
        }
    }

    func search() async {

        if query.isEmpty {
            return
        }

        isLoading = true

        do {
            songs = try await APIService.shared.searchSongs(query: query)
        } catch {
            print(error)
        }

        isLoading = false
    }
}