import UIKit

class SearchController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    private let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        viewModel.bind { [weak self] state in
            switch state {
            case .result:
                self?.tableView.reloadData()
            default:
                break
            }
        }
        viewModel.search(with: "Swift")
    }
}

extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let repository = viewModel.repositories[indexPath.row]
        cell.textLabel?.text = repository.name

        return cell
    }
}
