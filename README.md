<p align="center">
  <img src="docs/logo_marvel.png" align="center" height="128px" width="300px">
</p>

# Marvel Challange

This is a technical challenge for a selection process for junior iOS developer.

## Challange Description

Create a mobile application using [**Marvel's public API**](https://developer.marvel.com)

The application should list the Marvel characters on a screen with
infinite scroll and detail each character on another screen (it's not
use all information provided in the API).

### Architecture

In this project I used VIP.

This architecture was born with the intention of taking the weight of ViewControllers and increasing the testability of the code. Each screen is considered a scene which is formed by six components: ViewController, Presenter, Interactor, Worker, Models and Router. The connection between all these components is made using protocols.

For more information on vip architecture visit [**Clean Swift (VIP)**](https://medium.com/@leodegeus7/clean-swift-vip-como-organizar-melhor-nossos-códigos-f06762fc5cc2)

<p align="center">
  <img width="600" alt="vip_architecture" src="https://miro.medium.com/max/1400/0*gH_ZFdMDaAmmzKjK.png" align="center"><br /><br />
</p>

### Requirements

* Swift 5.0
* Xcode 10.0+
* iOS 13.6+

### Used Libraries

* [**CryptoSwift**](https://github.com/krzyzanowskim/CryptoSwift)

### Screenshots

### Installation

### Author

| [![Larissa](https://avatars.githubusercontent.com/u/55598696?v=4&s=80)](https://github.com/laridtm/) | [@laridtm](https://github.com/laridtm/) |
| ------ | ------ |
