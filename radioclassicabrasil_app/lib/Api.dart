import 'package:radioclassicabrasilapp/model/Video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const CHAVE_YOUTUBE_API = "AIzaSyBONmi6elk3vYA_XoIBH7ViksHpBC6ROJg";
const ID_CANAL = "UCx3wWEVu34XfhYAPIzCy7Ew";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {

  Future<List<Video>> pesquisar(String pesquisa) async {
    http.Response response = await http.get(
        URL_BASE + "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa"
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Video> videos = dadosJson ["items"].map<Video>(
              (map) {
            return Video.fromJson(map);
            //return Video.converterJson(map);

          }
      ).toList();

      return videos;

      /*
      for ( var video in dadosJson ["itens"]){
        print ("Resultado: " + video.toString() );
      }*/

    } else {

    }
  }


}