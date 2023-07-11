import 'data_fetcher.dart';

class UserData {

  final String cf_handle;

  UserData({
    required this.cf_handle,
});

  Future<CodeforcesUser?> getUser() async{
    DataFetcher df = DataFetcher('https://codeforces.com/api/user.info?handles=$cf_handle');
    final data = await df.fetchAlbum();
    if(data['status']=='OK'){
       CodeforcesUser user = CodeforcesUser(
         contribution: data['result'][0]['contribution'],
         lastOnline: data['result'][0]['lastOnlineTimeSeconds'],
         rating: data['result'][0]['rating'],
         friendsCount: data['result'][0]['friendOfCount'],
         titlePhoto: data['result'][0]['titlePhoto'],
         rank: data['result'][0]['rank'],
         handle: data['result'][0]['handle'],
         maxRank: data['result'][0]['maxRank'],
         maxRating: data['result'][0]['maxRating'],
         avatar: data['result'][0]['avatar'],
         registrationTime: data['result'][0]['registrationTimeSeconds'],
       );
       return user;
    }
    else {
      return null;
    }
  }
}

class CodeforcesUser{
  final int contribution;
  final int lastOnline;
  final int rating;
  final int friendsCount;
  final String titlePhoto;
  final String rank;
  final String handle;
  final int maxRating;
  final String avatar;
  final int registrationTime;
  final String maxRank;
  CodeforcesUser({
    this.contribution = 0,
    this.lastOnline = 0,
    this.rating = 0,
    this.friendsCount = 0,
    this.titlePhoto = '',
    this.rank = 'Unrated',
    this.handle = 'Unrated',
    this.maxRating = 0,
    this.avatar = '',
    this.registrationTime = 0,
    this.maxRank = 'Unrated',
});
}