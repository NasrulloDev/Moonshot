//
//  ContentView.swift
//  Moonshot
//
//  Created by Насрулло Исмоилжонов on 05/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showAsList = false
    let astronauts: [String: Astronout] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var columns: [GridItem] {
        return [GridItem(.adaptive(minimum: (showAsList ? 300 : 150)))]
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(missions){ mission in
                        NavigationLink(value: mission){
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack{
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationDestination(for: Mission.self){ selection in
                MissionView(mission: selection, astronauts: astronauts)
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar{
                Button("Change layout", systemImage: (showAsList ? "slider.horizontal.below.square.filled.and.square" : "slider.horizontal.below.rectangle")){
                    showAsList.toggle()
                }
                .buttonStyle(.bordered)
                .font(.title)
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
