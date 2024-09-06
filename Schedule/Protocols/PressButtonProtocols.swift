//
//  PressButtonProtocols.swift
//  Schedule
//
//  Created by Nick Khachatryan on 09.05.2024.
//

import Foundation

protocol PressReadyTaskButtonProtocol: AnyObject {
    func readyButtonTapped(indexPath: IndexPath)
}

protocol SwitchRepeatProtocol: AnyObject {
    func SwitchRepeatProtocol(value: Bool)
}
