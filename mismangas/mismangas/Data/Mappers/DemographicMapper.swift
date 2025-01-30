//
//  Demographic.swift
//  mismangas
//
//  Created by Michel Marques on 13/12/24.
//


extension DemographicDTO {
    func toDomain() -> Demographic {
        return Demographic(id: id, demographic: demographic)
    }
}
