//
//  HelpingMethods.swift
//  vdm-spaceapp-ios-v4
//
//  Created by Vattimo, Matteo (VDM) on 25/10/23.
//

import SwiftUI

func imageDownload(url: String, width: CGFloat, height: CGFloat) -> some View {
    AsyncImage(url: URL(string: (url))) { image in
        image
            .resizable()
            .frame(width: width, height: height)
            .scaledToFit()
    } placeholder: {
        ProgressView()
            .frame(width: width, height: height)
            .scaledToFit()
    }
}

func dateTimeConverter(utcDateString: String) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    
    guard let utcDate = dateFormatter.date(from: utcDateString) else { return "Date Error" }
    
    dateFormatter.dateFormat = "d MMM YYYY, hh:mm a"
    return dateFormatter.string(from: utcDate)
}
