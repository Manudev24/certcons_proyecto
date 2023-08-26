import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:certcons_proyecto/models/toolModel.dart';
import 'package:certcons_proyecto/widgets/itemWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToolModel> toolsAvalibles = [
    ToolModel(id: '1', name: 'Pala', date: '13 feb 2022'),
    ToolModel(id: '2', name: 'Martillo', date: '20 ene 2022'),
    ToolModel(id: '3', name: 'Destornillador', date: '13 dic 2022'),
    ToolModel(id: '4', name: 'Sierra', date: '19 feb 2022'),
    ToolModel(id: '5', name: 'Llave ajustable', date: '10 feb 2022'),
    ToolModel(id: '6', name: 'Taladro', date: '22 feb 2022'),
    ToolModel(id: '7', name: 'Cinta métrica', date: '13 feb 2022'),
    ToolModel(id: '8', name: 'Nivel', date: '09 feb 2022'),
    ToolModel(id: '9', name: 'Alicates', date: '21 feb 2022'),
    ToolModel(id: '10', name: 'Llave de tubo', date: '11 feb 2022'),
    ToolModel(id: '11', name: 'Pistola de calor', date: '18 ene 2022'),
    ToolModel(id: '12', name: 'Gato hidráulico', date: '10 feb 2022'),
    ToolModel(id: '13', name: 'Cincel', date: '09 ago 2022'),
    ToolModel(id: '14', name: 'Lijadora', date: '02 sep 2022'),
    ToolModel(id: '15', name: 'Sierra de calar', date: '23 nov 2022'),
  ];
  List<ToolModel> toolsChosen = [];

  int quantityChosen = 0;
  int quantityAvalibles = 0;

  @override
  void initState() {
    super.initState();
    quantityAvalibles = toolsAvalibles.length;
  }

  Widget adaptiveAction(
      {required BuildContext context,
      required VoidCallback onPressed,
      required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    'Herramientas disponibles: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    quantityAvalibles.toString(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: toolsAvalibles.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (quantityChosen != 10 ||
                                    quantityChosen > 10) {
                                  quantityAvalibles--;
                                  quantityChosen++;
                                  toolsChosen.add(toolsAvalibles[index]);
                                  toolsAvalibles.removeAt(index);
                                } else {
                                  showAdaptiveDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog.adaptive(
                                      title: const Text('Alerta'),
                                      content: const Text(
                                          'No puedes seleccionar más de 10 herramientas.'),
                                      actions: <Widget>[
                                        adaptiveAction(
                                          context: context,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Aceptar'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              });
                            },
                            child: ItemWidget(
                              id: toolsAvalibles[index].id,
                              name: toolsAvalibles[index].name,
                              date: toolsAvalibles[index].date,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    'Herramientas elegidas: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${quantityChosen}/10',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: toolsChosen.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                quantityAvalibles++;
                                quantityChosen--;
                                toolsAvalibles.add(toolsChosen[index]);
                                toolsChosen.removeAt(index);
                              });
                            },
                            child: ItemWidget(
                              id: toolsChosen[index].id,
                              name: toolsChosen[index].name,
                              date: toolsChosen[index].date,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}
