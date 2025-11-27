import 'dart:convert';
import 'package:http/http.dart' as http; // Opcional, mas útil se outras lógicas de API forem adicionadas.

// Modelo de Dados do Cuidador
class CaregiverModel {
 final String nome;
 final String numero;
 final String dataNascimento;
 final String endereco;
 final String infoFisicas;
 final String fotoUrl;

 CaregiverModel({
  required this.nome,
  required this.numero,
  required this.dataNascimento,
  required this.endereco,
  required this.infoFisicas,
  required this.fotoUrl,
 });

 factory CaregiverModel.fromJson(Map<String, dynamic> json) {
  return CaregiverModel(
   nome: json['nome'] ?? 'Nome Indisponível',
   numero: json['numero'] ?? 'Não informado',
   dataNascimento: json['data_nascimento'] ?? 'Não informada',
   endereco: json['endereco'] ?? 'Não informado',
   infoFisicas: json['info_fisicas'] ?? 'Sem informações físicas',
   fotoUrl: json['foto_url'] ?? 'assets/placeholder.png',
  );
 }
}