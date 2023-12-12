//
//  CountryModel.swift
//  WhisperProject
//
//  Created by Abdelrahman Shera on 10/12/2023.
//

import Foundation
struct Country : Identifiable , Hashable {
        let id : String = UUID().uuidString
        let name: String
        let code: String
        let flag: String
}

let arabianCountries = [ Country(name: "Bahrain", code: "+973", flag: "🇧🇭"),
                         Country(name: "Djibouti", code: "+253", flag: "🇩🇯"),
                         Country(name: "Egypt", code: "+20", flag: "🇪🇬"),
                         Country(name: "Iraq", code: "+964", flag: "🇮🇶"),
                         Country(name: "Jordan", code: "+962", flag: "🇯🇴"),
                         Country(name: "Kuwait", code: "+965", flag: "🇰🇼"),
                         Country(name: "Lebanon", code: "+961", flag: "🇱🇧"),
                         Country(name: "Libya", code: "+218", flag: "🇱🇾"),
                         Country(name: "Mauritania", code: "+222", flag: "🇲🇷"),
                         Country(name: "Morocco", code: "+212", flag: "🇲🇦"),
                         Country(name: "Oman", code: "+968", flag: "🇴🇲"),
                         Country(name: "Palestine", code: "+970", flag: "🇵🇸"),
                         Country(name: "Qatar", code: "+974", flag: "🇶🇦"),
                         Country(name: "Saudi Arabia", code: "+966", flag: "🇸🇦"),
                         Country(name: "Somalia", code: "+252", flag: "🇸🇴"),
                         Country(name: "Sudan", code: "+249", flag: "🇸🇩"),
                         Country(name: "Syrian Arab Republic", code: "+963", flag: "🇸🇾"),
                         Country(name: "Tunisia", code: "+216", flag: "🇹🇳"),
                         Country(name: "United Arab Emirates", code: "+971", flag: "🇦🇪"),
                         Country(name: "Yemen", code: "+967", flag: "🇾🇪")
]
