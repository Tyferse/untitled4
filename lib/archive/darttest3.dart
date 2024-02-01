var num = 0;
var ward = 'hell';
const int ii = -1;
double dd = 0.99;
String ss = 'd2';
const bool bb = false;


class Chel {
  String name;
  int age;
  bool gender;
  List<String> job;
  Chel(this.name, this.age, this.gender, this.job);

  info() {
    return 'Chel $name is a $age years old '
        '${gender ? "man" : "woman"} ${job.join(', ')}.';
  }
}


void main() {
  print("Sasusi\"\n-4");
  // print('Fuck you asshole? flutter')
  /*faf e
   fsgosm;gmspg
   esgos[kg[sg.s

   sgsg*/

  num++;
  print('$ward ${num-- + 3} but $bb is ${ss.toUpperCase()}');

  dynamic dym = 5;
  dym = 'yes';
  print(dym);

  var v1 = 15, v2 = 7;
  print('\nv1 + v2 = ${v1 + v2}');
  print('v1 - v2 = ${v1 - v2}');
  print('v1 * v2 = ${v1 * v2}');
  print('v1 / v2 = ${v1 ~/ v2}');
  print('v1 % v2 = ${v1 % v2}\n');
  if (v1 > 10 && (v1 > v2 && v2 > 4)) {
    print('v1 + v2 > 15');
  }
  else if ((v2 < v1 && v1 < 16) || v2 >= 8) {
    print('v1 - v2 <= 29');
  }
  else {
    v2++;
    v1 %= v2;
  }

  var v3 = v2 > v1 ? v2 + 1 : v1 - 1;
  print(v3);

  switch (v3) {
    case 8:
      print('gg');
      break;
    case 14:
      print('wp');
      break;
    default:
      print('hui');
  }

  // Списки
  var listOf = [];
  listOf.add(num);
  print('\n$listOf');

  listOf.addAll([9, 0.34, 'r']);
  print(listOf);

  listOf.add(9);
  listOf.remove(9);
  print(listOf);

  listOf.removeAt(2);
  print(listOf);

  listOf.addAll([1, 9, 23, 4, 6, 7, 5, 5, 8, 2]);
  listOf.removeWhere((elem) => elem >= 8 || elem % 1 != 0);
  print(listOf);

  print('\nfirst: ${listOf.first}, last: ${listOf.last}, '
      'length: ${listOf.length}');

  // List<int> li = [];
  // Set<int> si = {2, 2, 2, 4, 5, 6, 4};
  var si = {2, 2, 2, 5, 4, 6, 4};
  print(si);

  print('\n\n');
  int i = 0;
  while (i < si.length) {
    print(si.elementAt(i));
    i++;
  }

  for (var elem in listOf) {
    elem + 1;
  }
  listOf.forEach(print);
  si.forEach(print);

  for (int i = 0; i < listOf.length; i++) {
    print(listOf[i] * 2);
  }

  for (int el in si) {
    print(el / 2 + 10);
  }

  do {
    print(listOf[i--]);
  } while (i >= 0);

  var suschtsch = Chel('Suschtschenko A. A.', 39, true,
      ['doebivatel do studentov', 'header of department', 'hui']);
  print(suschtsch.info());

  // List<String> ward2 = ward.split('');
  // ward2.removeLast();
  // ward = ward2.join('');
  var ward2 = ward.split('');
  ward2.removeLast();
  print(ward2.join(''));


  dynamic entries = ['0.12'];
  var nums = [];
  var ops = [];

  if (entries.length % 2 != 1) {
    entries.removeLast();
  }

  for (i = 0; i < entries.length; i++) {
    if (i % 2 == 0){
      nums.add(double.parse(entries[i]));
    }
    else {
      ops.add(entries[i]);
    }
  }

  if (ops.any((elem) => ['*', '/'].contains(elem))) {
    for (int i = 0; i < ops.length; i++) {
      if (ops[i] == '*') {
        nums[i] *= nums[i + 1];
        nums.removeAt(i + 1);
        ops.removeAt(i);
        i--;
      }
      else if (ops[i] == '/') {
        nums[i] /= nums[i + 1];
        nums.removeAt(i + 1);
        ops.removeAt(i);
        i--;
      }
    }
  }

  print(nums);
  double result = nums.first;
  for (int i = 0; i < ops.length; i++) {
    if (ops[i] == '+') {
      result += nums[i + 1];
    }
    else if (ops[i] == '-') {
      result -= nums[i + 1];
    }
  }
  print(result);
}
