class Size {
  final double width;
  final double height;

  Size({
      required this.width,
      required this.height,});

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    width : json['width'],
    height : json['height'],
  );

  Map<String, dynamic> toJson() => {
    'width' : width,
    'height' : height,
  };

}