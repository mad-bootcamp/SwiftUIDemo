//
//  BannerError.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/11/26.
//

//under ArtistList  before Hstack, delete and enter BannerError(model: viewModel)
//under ArtistList ViewModel should conform to Failable and same with boardmember

//dont forget finish protocol and contentview set up

//in conctentview : add environment

import SwiftUI

struct BannerError: View {

    private let model: Failable

    init(model: Failable) {
        self.model = model
    }

    var body: some View {
        if model.errorMessage != " "{
            Text(model.errorMessage)
                .foregroundColor(Color(.systemRed))
                .background(Color(.red).opacity(0.1))
                .padding()
        }
    }
}
