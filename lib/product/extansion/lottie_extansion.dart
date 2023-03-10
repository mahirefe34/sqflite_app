enum LottieItems { heart }

extension LottieItemsExtention on LottieItems {
  String _path() {
    switch (this) {
      case LottieItems.heart:
        return 'lottie_heart';
    }
  }

  String get lottiePath => 'assets/lottie/${_path()}.json';
}
