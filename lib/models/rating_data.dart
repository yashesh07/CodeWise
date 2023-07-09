

import 'data_fetcher.dart';

class RatingData {
  final String cf_handle;

  static List<RatingDataPerContest> ratingList = [];

  RatingData({
    required this.cf_handle,
});

  Future<bool> updateData() async{
    final ratings = await DataFetcher('https://codeforces.com/api/user.rating?handle=$cf_handle').fetchAlbum();
    if(ratings['status']=='OK'){
      ratingList = [];
      int count = 0;
      for(var ob in ratings['result']){
        ratingList.add(RatingDataPerContest(index: count, newRating: ob['newRating'], oldRating: ob['oldRating'], rank: ob['rank']));
        count++;
      }
      return true;
    }
    else{
      return false;
    }
  }

}

class RatingDataPerContest{
  int index;
  int newRating;
  int oldRating;
  int rank;
  RatingDataPerContest({
    required this.index,
    required this.newRating,
    required this.oldRating,
    required this.rank,
});
}