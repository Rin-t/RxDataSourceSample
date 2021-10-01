//
//  SettingViewModel.swift
//  RxDataSourceSample
//
//  Created by Rin on 2021/10/01.
//

import RxSwift
import RxCocoa
import RxDataSources

class SettingViewModel {

    let items = BehaviorRelay<[SettingsSectionModel]>(value: [])

    var itemObserbable: Observable<[SettingsSectionModel]> {
        return items.asObservable()
    }

    func setup() {
        updateItems()
    }

    func updateItems() {
        let sections: [SettingsSectionModel] = [
            accountSection(),
            commonSection()
        ]
        items.accept(sections)
    }

    private func accountSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
            .account,
            .security,
            .notification,
            .contents
        ]
        return SettingsSectionModel(model:  .account, items: items)
    }

    private func commonSection() -> SettingsSectionModel {
        let items: [SettingsItem] = [
            .sounds,
            .dataUsing,
            .accessibility,
            .description(text: "基本設定はこの端末でログインしている全てのアカウントに適用されます。")
        ]
        return SettingsSectionModel(model: .common, items: items)
    }
}
