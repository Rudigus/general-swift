//
//  OverlayAbuse.swift
//  Desafios
//
//  Created by Rodrigo Matos Aguiar on 01/06/21.
//

import SwiftUI

struct OverlayAbuse: View {
    
    let deviceFrame = UIScreen.main.bounds
    
    var body: some View {
        Color.red
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                Color.green
                    .frame(maxWidth: deviceFrame.width / 2, maxHeight: .infinity)
                    .offset(x: deviceFrame.width/4)
                    .overlay(
                        Color.blue
                            .frame(maxHeight: deviceFrame.height/2)
                            .offset(x: deviceFrame.width/4)
                        , alignment: .bottom)
            )
            .edgesIgnoringSafeArea(.all)
    }
    
}

struct OverlayAbuse_Previews: PreviewProvider {
    static var previews: some View {
        OverlayAbuse()
    }
}
