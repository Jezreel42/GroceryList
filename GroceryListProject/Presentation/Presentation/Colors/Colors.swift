//
//  Colors.swift
//  Presentation
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import UIKit.UIColor

/// Palette 🎨
public final class Palette {

    /// White ⬜️
    public struct White {
        public static var white: UIColor { #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) }
        public static var ghostWhite: UIColor { #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1) }
    }

    /// Gray  🌫
    public struct Gray {
        public static var jet: UIColor { #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 1) }
        public static var devisGrey: UIColor { #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3450980392, alpha: 1) }
    }

    /// Black ⬛️
    public struct Black {
        public static var black: UIColor { #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }
        public static var eerieBlack: UIColor { #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1) }
    }

    /// Red 🟥
    public struct Red {
        public static var fireBrick: UIColor { #colorLiteral(red: 0.7333333333, green: 0.1568627451, blue: 0.1450980392, alpha: 1) }
    }

    /// Green 🟩
    public struct Green {
        public static var mossGreen: UIColor { #colorLiteral(red: 0.4862745098, green: 0.5176470588, blue: 0.3215686275, alpha: 1) }
    }

    /// Blue 🟦
    public struct Blue {
        public static var lapisLazule: UIColor { #colorLiteral(red: 0.2, green: 0.3960784314, blue: 0.5411764706, alpha: 1) }
    }

    /// Yellow 🟨
    public struct Yellow {

    }

    /// Orange 🟧
    public struct Orange {

    }

    /// Purple 🟪
    public struct Purple {

    }

    /// Brown 🟫
    public struct Brown {
        public static var brown: UIColor { #colorLiteral(red: 0.5333333333, green: 0.3725490196, blue: 0.1411764706, alpha: 1) }
        public static var sepia: UIColor { #colorLiteral(red: 0.4196078431, green: 0.262745098, blue: 0.03921568627, alpha: 1) }
        public static var matallicSunburst: UIColor { #colorLiteral(red: 0.631372549, green: 0.5098039216, blue: 0.3176470588, alpha: 1) }
    }

    /// Texture 📜
    public struct Texture {

    }
}
