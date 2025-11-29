import 'package:flutter/material.dart';
import 'package:algumacoisa/cuidador/selecao_paciente_medicamento_screen.dart';

class AgendarMedicamentoScreen extends StatefulWidget {
  const AgendarMedicamentoScreen({super.key});

  @override
  State<AgendarMedicamentoScreen> createState() =>
      _AgendarMedicamentoScreenState();
}

class _AgendarMedicamentoScreenState extends State<AgendarMedicamentoScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  bool _isLoading = false;
  bool _isRecurring = false; // Nova variável para controlar se é recorrente

  Future<void> _scheduleMedicine() async {
    if (_selectedTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Selecione um horário')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Combina data e hora
    final selectedDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      int.parse(_selectedTime!.split(':')[0]),
      int.parse(_selectedTime!.split(':')[1]),
    );

    try {
      // Navega para a tela de seleção de paciente
      _navigateToNextScreen(selectedDateTime);
    } catch (e) {
      print('Erro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao agendar. Tente novamente.')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Função dedicada para navegação
  void _navigateToNextScreen(DateTime selectedDateTime) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelecionarPacienteMedicamento(
          selectedDate: _selectedDate,
          selectedTime: _selectedTime!,
          selectedDateTime: selectedDateTime,
          isRecurring: _isRecurring, // Passa a informação de recorrência
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color corPrincipal = Color(0xFF6ABAD5);
    final month = _selectedDate.month;
    final year = _selectedDate.year;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: corPrincipal),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Agenda para marcar medicamento',
          style: TextStyle(color: corPrincipal, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildCalendar(month, year),
              SizedBox(height: 24),

              // Botão "Para todos os dias"
              _buildRecurringButton(),
              SizedBox(height: 16),

              Text(
                'Adicione o Horário:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: corPrincipal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              _buildTimeGrid(),
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: ElevatedButton(
                  onPressed: (_selectedTime != null && !_isLoading)
                      ? _scheduleMedicine
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (_selectedTime != null && !_isLoading)
                        ? corPrincipal
                        : Colors.grey[200],
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            strokeWidth: 3,
                          ),
                        )
                      : Text(
                          'Próximo',
                          style: TextStyle(
                            color: _selectedTime != null
                                ? Colors.white
                                : Colors.grey[600],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para o botão "Para todos os dias"
  Widget _buildRecurringButton() {
    const Color corPrincipal = Color(0xFF6ABAD5);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _isRecurring ? corPrincipal : Colors.grey.withOpacity(0.4),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
        color: _isRecurring ? corPrincipal.withOpacity(0.1) : Colors.white,
      ),
      child: ListTile(
        leading: Icon(
          _isRecurring ? Icons.check_circle : Icons.radio_button_unchecked,
          color: _isRecurring ? corPrincipal : Colors.grey,
        ),
        title: Text(
          'Para todos os dias',
          style: TextStyle(
            color: _isRecurring ? corPrincipal : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: _isRecurring
            ? Text(
                'Este medicamento será repetido diariamente',
                style: TextStyle(
                  color: corPrincipal.withOpacity(0.7),
                  fontSize: 12,
                ),
              )
            : null,
        trailing: _isRecurring ? Icon(Icons.repeat, color: corPrincipal) : null,
        onTap: () {
          setState(() {
            _isRecurring = !_isRecurring;
          });
        },
      ),
    );
  }

  Widget _buildCalendar(int month, int year) {
    const Color corPrincipal = Color(0xFF6ABAD5);
    final daysOfWeek = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];

    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    final daysInMonthCount = lastDayOfMonth.day;
    final leadingEmptyDays = firstDayOfMonth.weekday % 7;

    final daysInMonth = [
      ...List.generate(leadingEmptyDays, (_) => ''),
      ...List.generate(daysInMonthCount, (index) => (index + 1).toString()),
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(year, month - 1, 1);
                  _selectedTime = null;
                });
              },
            ),
            Text(
              '${_getMonthName(month)}\n$year',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: corPrincipal,
              ),
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(year, month + 1, 1);
                  _selectedTime = null;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.0,
          ),
          itemCount: daysOfWeek.length,
          itemBuilder: (context, index) {
            return Center(
              child: Text(
                daysOfWeek[index],
                style: TextStyle(color: corPrincipal),
              ),
            );
          },
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.0,
          ),
          itemCount: daysInMonth.length,
          itemBuilder: (context, index) {
            final day = daysInMonth[index];
            final isCurrentMonthDay = day.isNotEmpty;
            final dayInt = isCurrentMonthDay ? int.parse(day) : -1;

            final isSelected =
                isCurrentMonthDay &&
                dayInt == _selectedDate.day &&
                month == _selectedDate.month &&
                year == _selectedDate.year;

            final DateTime currentDayDate = isCurrentMonthDay
                ? DateTime(year, month, dayInt)
                : DateTime.now().add(Duration(days: 9999));
            final bool isPastDate = currentDayDate.isBefore(
              DateTime.now().subtract(Duration(days: 1)),
            );

            return GestureDetector(
              onTap: isCurrentMonthDay && !isPastDate
                  ? () {
                      setState(() {
                        _selectedDate = DateTime(year, month, dayInt);
                        _selectedTime = null;
                      });
                    }
                  : null,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? corPrincipal.withOpacity(0.1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    day,
                    style: TextStyle(
                      color: isSelected
                          ? corPrincipal
                          : (isPastDate
                                ? Colors.grey.shade400
                                : (isCurrentMonthDay
                                      ? Colors.black
                                      : Colors.transparent)),
                      fontWeight: isSelected || isCurrentMonthDay
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimeGrid() {
    const Color corPrincipal = Color(0xFF6ABAD5);
    final times = [
      '8:00',
      '9:00',
      '11:00',
      '12:00',
      '14:00',
      '15:00',
      '17:00',
      '18:00',
      '19:00',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: times.length,
      itemBuilder: (context, index) {
        final time = times[index];
        final isSelected = _selectedTime == time;

        return OutlinedButton(
          onPressed: () {
            setState(() {
              _selectedTime = time;
            });
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: isSelected
                ? corPrincipal.withOpacity(0.1)
                : Colors.white,
            side: BorderSide(
              color: isSelected
                  ? Colors.transparent
                  : corPrincipal.withOpacity(0.4),
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            time,
            style: TextStyle(
              color: isSelected ? corPrincipal : corPrincipal.withOpacity(0.6),
            ),
          ),
        );
      },
    );
  }

  String _getMonthName(int month) {
    const months = [
      "Janeiro",
      "Fevereiro",
      "Março",
      "Abril",
      "Maio",
      "Junho",
      "Julho",
      "Agosto",
      "Setembro",
      "Outubro",
      "Novembro",
      "Dezembro",
    ];
    return months[month - 1];
  }
}
