//
//  ForecastTableViewCell.swift
//  WavesCheck
//
//  Created by Bruno Lopes on 01/06/22.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    static let identifier: String = "ForecastTableViewCell"
    
    lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(17)
        label.text = "Segunda-feira 16/05"
        return label
    }()
    
    lazy var wavesSizeIconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "waveIcon")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var wavesSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(17)
        label.text = "1.8 - 2.5"
        return label
    }()
    
    lazy var periodIconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "clock")
        image.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(17)
        label.text = "13s"
        return label
    }()
    
    lazy var swellDirectionIconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "location.circle")
        image.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var swellDirectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(17)
        label.text = "NE"
        return label
    }()
    
    lazy var windIconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "wind")
        image.tintColor = UIColor(red: 55/255, green: 67/255, blue: 91/255, alpha: 1.0)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = label.font.withSize(17)
        label.text = "36/NE"
        return label
    }()
    
    
    //MARK: - Initializers
    
    let viewModel = ForecastTableViewCellViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configBackGround()
        addSubView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Functions
        
    public func setUpCell(forecast: Hour, date: String) {
        dateLabel.text = date
        wavesSizeLabel.text = "\(String(format: "%.1f", forecast.waveHeight?.noaa ?? 0))m"
        periodLabel.text = "\(String(format: "%.0f", forecast.wavePeriod?.noaa ?? 7))s"
        swellDirectionLabel.text = viewModel.getSwellDirectionString(parametro: forecast.swellDirection?.noaa ?? 0)
        windLabel.text = "\(String(format: "%.0f", forecast.windSpeed?.noaa ?? 0))/\(viewModel.getWindDirectionString(parametro: forecast.windDirection?.noaa ?? 0))"
    }
    
    //MARK: - Private Functions
    
    private func configBackGround() {
        backgroundColor = .white
    }
    
    private func addSubView() {
        contentView.addSubview(topView)
        topView.addSubview(dateLabel)
        contentView.addSubview(wavesSizeIconImageView)
        contentView.addSubview(wavesSizeLabel)
        contentView.addSubview(periodIconImageView)
        contentView.addSubview(periodLabel)
        contentView.addSubview(swellDirectionIconImageView)
        contentView.addSubview(swellDirectionLabel)
        contentView.addSubview(windIconImageView)
        contentView.addSubview(windLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            wavesSizeIconImageView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            wavesSizeIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            wavesSizeIconImageView.heightAnchor.constraint(equalToConstant: 30),
            wavesSizeIconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            wavesSizeLabel.centerYAnchor.constraint(equalTo: wavesSizeIconImageView.centerYAnchor),
            wavesSizeLabel.leadingAnchor.constraint(equalTo: wavesSizeIconImageView.trailingAnchor, constant: 10),
            wavesSizeLabel.widthAnchor.constraint(equalToConstant: 76),
            
            periodIconImageView.centerYAnchor.constraint(equalTo: wavesSizeIconImageView.centerYAnchor),
            periodIconImageView.leadingAnchor.constraint(equalTo: wavesSizeLabel.trailingAnchor, constant: 8),
            periodIconImageView.heightAnchor.constraint(equalToConstant: 30),
            periodIconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            periodLabel.centerYAnchor.constraint(equalTo: wavesSizeIconImageView.centerYAnchor),
            periodLabel.leadingAnchor.constraint(equalTo: periodIconImageView.trailingAnchor, constant: 10),
            periodLabel.widthAnchor.constraint(equalToConstant: 26.5),
            
            swellDirectionIconImageView.centerYAnchor.constraint(equalTo: wavesSizeIconImageView.centerYAnchor),
            swellDirectionIconImageView.leadingAnchor.constraint(equalTo: periodLabel.trailingAnchor, constant: 10),
            swellDirectionIconImageView.heightAnchor.constraint(equalToConstant: 30),
            swellDirectionIconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            swellDirectionLabel.centerYAnchor.constraint(equalTo: wavesSizeIconImageView.centerYAnchor),
            swellDirectionLabel.leadingAnchor.constraint(equalTo: swellDirectionIconImageView.trailingAnchor, constant: 10),
            swellDirectionLabel.widthAnchor.constraint(equalToConstant: 24),
            
            windIconImageView.centerYAnchor.constraint(equalTo: wavesSizeIconImageView.centerYAnchor),
            windIconImageView.leadingAnchor.constraint(equalTo: swellDirectionLabel.trailingAnchor, constant: 10),
            windIconImageView.heightAnchor.constraint(equalToConstant: 30),
            windIconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            windLabel.centerYAnchor.constraint(equalTo: wavesSizeIconImageView.centerYAnchor),
            windLabel.leadingAnchor.constraint(equalTo: windIconImageView.trailingAnchor, constant: 10),
            windLabel.widthAnchor.constraint(equalToConstant: 54)
            
        ])
    }
}
