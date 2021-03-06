//
//  SettingsModel.swift
//  RxDataSourceSample
//
//  Created by Rin on 2021/10/01.
//

//import UIKit
import Foundation
import RxDataSources

typealias SettingsSectionModel = SectionModel<SettingsSection, SettingsItem>

enum SettingsSection {
    case account
    case common

    var headerHeight: CGFloat {
        return 40.0
    }

    var footerHeight: CGFloat {
        return 1.0
    }

}

enum SettingsItem {
    // account section
    case account
    case security
    case notification
    case contents
    // common section
    case sounds
    case dataUsing
    case accessibility

    // other
    case description(text: String)

    var title: String? {
        switch self {
        case .account:
            return "アカウント"
        case .security:
            return "セキュリティー"
        case .notification:
            return "通知"
        case .contents:
            return "コンテンツ設定"
        case .sounds:
            return "サウンド設定"
        case .dataUsing:
            return "データ利用事の設定"
        case .accessibility:
            return "アクセシビリティ"
        case .description(let text):
            return "nil"
        }
    }


    var rowHeight: CGFloat {
        switch self {
        case .description:
            return 72.0

        default:
            return 48.0
        }
    }

    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility:
            return .disclosureIndicator
        case .description:
            return .none
        }
    }

}
