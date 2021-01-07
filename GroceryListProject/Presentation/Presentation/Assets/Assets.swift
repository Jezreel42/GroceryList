//
//  Assets.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit.UIImage

public protocol AssetImage: RawRepresentable {

    var image: UIImage { get }
}

extension AssetImage where RawValue == String {

    public var image: UIImage {
        UIImage(named: rawValue, in: Bundle(for: Assets.self), compatibleWith: nil) ?? UIImage()
    }
}

public final class Assets {

    public enum Basics: String, AssetImage {

        case example
    }
}
