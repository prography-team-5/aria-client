enum Environ { dev, prod }

class Env {
  static Environ env = Environ.dev;
  static String get apiUrl {
    switch (env) {
      case Environ.dev:
        return 'http://localhost:3000';
      case Environ.prod:
        return 'https://api.example.com';
      default:
        return 'http://localhost:3000';
    }
  }
}
