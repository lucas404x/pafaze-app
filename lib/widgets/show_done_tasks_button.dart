import 'package:flutter/material.dart';

class ShowDoneTasksButton extends StatelessWidget {
  final bool show;
  final Function onTap;
  const ShowDoneTasksButton({Key? key, required this.show, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: GestureDetector(
          onTap: () => onTap(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(show ? 0xFFFFDCDC : 0xFFDCF4FF),
                ),
                child: Text(
                  show
                      ? 'Ocultar tarefas concluídas'
                      : 'Clique aqui para exibir tarefas concluidas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(show ? 0xFFC80000 : 0xFF0089C8)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
