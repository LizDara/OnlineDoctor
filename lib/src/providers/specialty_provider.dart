import 'package:http/http.dart' as http;
import 'package:online_doctor/src/models/specialty_model.dart';
import 'package:online_doctor/src/providers/global.dart';

class SpecialtyProvider {
  Future<List<Specialty>> getSpecialties() async {
    final response = await http.get(
      Uri.parse('$baseUrl/especialidades/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<Specialty> specialty = specialtyFromJson(response.body);
      return specialty;
    }
    return [];
  }
}
