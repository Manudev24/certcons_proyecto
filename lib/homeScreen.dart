import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:certcons_proyecto/models/toolModel.dart';
import 'package:certcons_proyecto/widgets/itemWidget.dart';
import 'package:pull_down_button/pull_down_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToolModel> toolsAvailable = [
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
  int quantityAvailable = 0;
  void _showAlertDialog(BuildContext context, int index) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Eliminar herramienta'),
        content:
            const Text('Estás seguro que quieres eliminar esta herramienta?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              setState(() {
                quantityAvailable++;
                quantityChosen--;
                toolsAvailable.add(toolsChosen[index]);
                toolsChosen.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    quantityAvailable = toolsAvailable.length;
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
                    quantityAvailable.toString(),
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
                        itemCount: toolsAvailable.length,
                        itemBuilder: (context, index) {
                          return Draggable<ToolModel>(
                            data: toolsAvailable[index],
                            feedback: Container(
                              width: 90,
                              height: 90,
                              child: Opacity(
                                  opacity: 0.5,
                                  child: Image(
                                      image: AssetImage(
                                          'assets/${toolsAvailable[index].id}.png'))),
                            ),
                            childWhenDragging:
                                Icon(Icons.drag_indicator, size: 50),
                            child: ItemWidget(toolModel: toolsAvailable[index]),
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
                      // Envolvemos el ListView en un widget DragTarget
                      child: DragTarget<ToolModel>(
                        // Definimos lo que pasa cuando aceptamos una herramienta que se arrastra sobre la lista
                        onAccept: (tool) {
                          // Actualizamos el estado de las listas y las cantidades
                          setState(() {
                            if (quantityChosen != 10 || quantityChosen > 10) {
                              quantityAvailable--;
                              quantityChosen++;
                              toolsChosen.add(tool);
                              toolsAvailable.remove(tool);
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Alerta'),
                                  content: Text(
                                      'No puedes seleccionar más de 10 herramientas.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Aceptar'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          });
                        },

                        builder: (context, candidateData, rejectedData) {
                          return toolsChosen.isEmpty
                              ? Center(child: Text('Arrastra aquí'))
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: toolsChosen.length,
                                  itemBuilder: (context, index) {
                                    return PullDownButton(
                                      itemBuilder: (context) => [
                                        PullDownMenuItem(
                                          onTap: () {
                                            _showAlertDialog(context, index);
                                          },
                                          title: 'Eliminar herramienta',
                                          isDestructive: true,
                                          icon: CupertinoIcons.delete,
                                        )
                                      ],
                                      // position: PullDownMenuPosition.under,
                                      buttonBuilder: (context, showMenu) =>
                                          CupertinoButton(
                                        onPressed: showMenu,
                                        padding: EdgeInsets.zero,
                                        child: ItemWidget(
                                          toolModel: toolsChosen[index],
                                        ),
                                      ),
                                    );
                                  },
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
