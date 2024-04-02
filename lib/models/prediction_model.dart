class PredictionModel
{
  String? place_id;
  String? main_text;
  String? secondary_text;

  PredictionModel({this.place_id, this.main_text, this.secondary_text});

  PredictionModel.fromJason(Map<String, dynamic> jason)
  {
    place_id = jason["place_id"];
    main_text = jason["structured_formatting"]["main_text"];
    secondary_text = jason["structured_formatting"]["secondary_text"];

  }
}