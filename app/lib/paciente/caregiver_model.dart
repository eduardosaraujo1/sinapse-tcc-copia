class CaregiverModel {
  final String nome;
  final String numero;
  final String dataNascimento;
  final String endereco;
  final String infoFisicas; // Tipo sanguíneo
  final String fotoUrl;
  final int? idade;
  final double? peso;
  final String? comorbidade;
  final String? email;

  CaregiverModel({
    required this.nome,
    required this.numero,
    required this.dataNascimento,
    required this.endereco,
    required this.infoFisicas,
    required this.fotoUrl,
    this.idade,
    this.peso,
    this.comorbidade,
    this.email,
  });

  factory CaregiverModel.fromJson(Map<String, dynamic> json) {
    return CaregiverModel(
      nome: json['nome'] ?? 'Nome Indisponível',
      numero: json['numero'] ?? 'Não informado',
      dataNascimento: json['data_nascimento'] ?? 'Não informada',
      endereco: json['endereco'] ?? 'Não informado',
      infoFisicas: json['info_fisicas'] ?? 'Sem informações físicas',
      fotoUrl: json['foto_url'] ?? 'assets/placeholder.png',
      idade: json['idade'],
      peso: json['peso'] != null ? double.tryParse(json['peso'].toString()) : null,
      comorbidade: json['comorbidade'],
      email: json['email'],
    );
  }
}