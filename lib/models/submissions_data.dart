
import 'dart:ui';

import 'data_fetcher.dart';

class SubmissionsData {

  final String cf_handle;
  static List<Problem> problems = [];
  static List<Verdict> verdicts = [];
  static List<Difficulty> difficulty = [];

  SubmissionsData({
    required this.cf_handle,
});

  Future<bool> updateData() async{
    final submissions = await DataFetcher('https://codeforces.com/api/user.status?handle=$cf_handle').fetchAlbum();
    if(submissions['status']=='OK'){
      problems = [];
      verdicts = [
        Verdict(status: 'accepted', count: 0, color: Color(0xFF98D8AA)),
        Verdict(status: 'compilation error', count: 0, color: Color(0xFFF15A59)),
        Verdict(status: 'runtime error', count: 0, color: Color(0xFFF7D060)),
        Verdict(status: 'wrong answer', count: 0, color: Color(0xFFFC2947)),
        Verdict(status: 'time limit exceeded', count: 0, color: Color(0xFF78C1F3)),
        Verdict(status: 'memory limit exceeded', count: 0, color: Color(0xFFFF8551)),
        Verdict(status: 'idleness limit exceeded', count: 0, color: Color(0xFFE966A0)),
        Verdict(status: 'others', count: 0, color: Color(0xFF9681EB)),
      ];
      difficulty = [];
      var problem_id = <String>{};
      var problem_distribution = {};
      var rating_distribution = {};
      for(var ob in submissions['result']){
        String p_id = ob['problem']['name']+"-"+ob['problem']['index'];
        try{
          verdicts[getVerdictIndex(ob['verdict'])].count++;
        }catch (e){
          continue;
        }
        if(problem_id .contains(p_id) || ob['verdict']!='OK') continue;
        problem_id.add(p_id);
        try{
          for(String s in ob['problem']['tags']){
            if(problem_distribution.containsKey(s)){
              problem_distribution[s]++;
            }
            else {
              problem_distribution[s] = 1;
            }
          }
        }finally{}
        try{
          if(rating_distribution.containsKey(ob['problem']['rating'])) {
            rating_distribution[ob['problem']['rating']]++;
          } else {
            if(ob['problem']['rating']!=null) rating_distribution[ob['problem']['rating']] = 1;
          }
        }finally{}
      }
      problem_distribution.forEach((key, value) { problems.add(Problem(tag: key, count: value));});
      rating_distribution.forEach((key, value) { difficulty.add(Difficulty(difficulty: key, count: value));});
      return true;
    }
    else{
      return false;
    }
  }

  int getVerdictIndex(String s){
    if(s=='OK') return 0;
    if(s=='COMPILATION_ERROR')  return 1;
    if(s=='RUNTIME_ERROR')  return 2;
    if(s=='WRONG_ANSWER')  return 3;
    if(s=='TIME_LIMIT_EXCEEDED')  return 4;
    if(s=='MEMORY_LIMIT_EXCEEDED')  return 5;
    if(s=='IDLENESS_LIMIT_EXCEEDED')  return 6;
    return 7;
  }
}

class Problem{

  final String tag;
  int count;

  Problem({
    required this.tag,
    required this.count,
});

}


class Verdict {

  final String status;
  int count;
  final Color color;

  Verdict({
    required this.status,
    required this.count,
    required this.color
});

}

class Difficulty {

  final int difficulty;
  int count;

  Difficulty({
    required this.difficulty,
    required this.count,
});

}