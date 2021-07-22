//
//  Home.swift
//  UI-266
//
//  Created by nyannyan0328 on 2021/07/22.
//

import SwiftUI

struct Home: View {
    @State var show = false
    
    @State var currentDay : Int = 1
    var body: some View {
        NavigationView{
            
            
            List{
                
                Section(header: Text("***Tutolials***")) {
                    
                    ForEach(1...20,id:\.self){index in
                        
                        Button {
                            
                            withAnimation{
                                
                                currentDay = index
                                
                                show.toggle()
                            }
                            
                        } label: {
                            Text("The day \(index) of Swift UI")
                        }
                        .foregroundColor(.primary)

                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Pop Up")
            
        }
        .SwipPopuUp(show: $show) {
            
            List{
                
                
                Section(header: Text("Day\(currentDay)")) {
                    
                    
                    ForEach(1...30,id:\.self){index in
                        
                        
                        Text("Course\(index)")
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
            }
        }
        
    
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
