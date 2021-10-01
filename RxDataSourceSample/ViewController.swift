//
//  ViewController.swift
//  RxDataSourceSample
//
//  Created by Rin on 2021/10/01.
//


import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let disposeBag = DisposeBag()

    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SettingsSectionModel>(configureCell: configureCell)

    private lazy var configureCell: RxTableViewSectionedReloadDataSource<SettingsSectionModel>.ConfigureCell = {  [weak self] (dateSource, tableView, indexPath, _) in
        let item = self?.dataSource[indexPath]
        switch item {
        case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility:
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item!.title
            cell.accessoryType = item!.accessoryType
            return cell
        case .description(let text):
            let cell = tableView
                .dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = text
            cell.isUserInteractionEnabled = false
            return cell
        default:
            return UITableViewCell()
        }
    }

    private var viewModel: SettingViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupViewModel()
        setupTableView()
    }
    private func setupViewController() {
        navigationItem.title = "設定"
    }

    private func setupTableView() {
        tableView
            .register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.bottom = 12
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.itemSelected
            .subscribe (onNext: { [weak self] indexPath in
                guard let item = self?.dataSource[indexPath] else { return }
                self?.tableView.deselectRow(at: indexPath, animated: true)
                switch item {
                case .account:
                    break
                case .security:
                    break
                case .notification:
                    break
                case .contents:
                    break
                case .sounds:
                    break
                case .dataUsing:
                    break
                case .accessibility:
                    break
                case .description:
                    break
                }
            })
            .disposed(by: disposeBag)
    }

    private func setupViewModel() {
        viewModel = SettingViewModel()

        viewModel.items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.updateItems()
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.rowHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.headerHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.footerHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}
