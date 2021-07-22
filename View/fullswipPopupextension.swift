//
//  fullswipPopupextension.swift
//  UI-266
//
//  Created by nyannyan0328 on 2021/07/22.
//

import SwiftUI

extension View{
    
    func SwipPopuUp<Content : View>(show : Binding<Bool>,content : @escaping()->Content) -> some View{
        
       FullSwipPopHeleper(show: show, content: content(), mainContent: self)
    }
    
    
    
}

struct fullswipPopupextension_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private struct FullSwipPopHeleper<Maincontent : View,Content : View> : View{
    
    
    
    
    
    var mainContent : Maincontent
    var content : Content
    @Binding var  show : Bool
    
    init(show : Binding<Bool>,content : Content,mainContent : Maincontent){
        
        
        self._show = show
        self.content = content
        self.mainContent = mainContent
    }
    
    @GestureState var gestureoffset : CGFloat = 0
    @State var offset : CGFloat = 0
    
    @Environment(\.colorScheme) var scheme
    
    var body: some View{
        
        GeometryReader{proxy in
            
           mainContent
                .offset(x:show && offset >= 0 ?  getoffset(size: proxy.size.width) : 0)
            
            
                .overlay(
                
                    ZStack{
                        
                        
                        if show{
                            
                            
                            content
                                .background(
                                
                                    (scheme == .dark ? Color.black : Color.white)
                                        .shadow(radius: 15)
                                        .ignoresSafeArea()
                                       
                                
                                
                                )
                                .offset(x: offset > 0 ? offset : 0)
                                .gesture(DragGesture().updating($gestureoffset, body: { value, out, _ in
                                    out = value.translation.width
                                }).onEnded({ value in
                                    
                                    withAnimation(.linear.speed(2)){
                                        
                                        offset = 0
                                        
                                        let translation = value.translation.width
                                        
                                        let maxTranslation = proxy.size.width / 2.5
                                        
                                        
                                        if translation > maxTranslation{
                                            
                                            show = false
                                        }
                                    
                                    }
                                    
                                }))
                                .transition(.move(edge: .trailing))
                        }
                        
                        
                        
                    }
                
                )
                .onChange(of: gestureoffset) { newValue in
                    
                    offset = gestureoffset
                    
                  
                    
                }
            
            
            
        }
       
        
    
    }
    func getoffset(size : CGFloat) -> CGFloat{
        
        
        let progress = offset / size
        
        let start : CGFloat = -80
        
        let progressWidth = (progress * 90) <= 90 ? (progress * 90) : 90
        
        let mainoffset = (start + progressWidth) < 0 ? (start + progressWidth) : 0
        
        return mainoffset
        
        
    }
    

    
   
    
    
}
